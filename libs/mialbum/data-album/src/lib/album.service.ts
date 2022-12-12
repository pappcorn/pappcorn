import { Injectable } from '@angular/core';
import {
  collection,
  doc,
  DocumentData,
  Firestore,
  getDocs,
  query,
  setDoc,
  updateDoc,
  where,
} from '@angular/fire/firestore';
import {
  Album,
  Figure,
  FigureCategory,
  FigurePrefix,
  FigureSection,
  FigureType,
  FirestoreCollections,
} from '@pappcorn/mialbum/util-interfaces';
import { NotificationsService } from '@pappcorn/shared/data-auth';
import { BehaviorSubject, combineLatest, map, Observable, tap } from 'rxjs';
import { generateNewAlbum } from './new-album.generator';

@Injectable({
  providedIn: 'root',
})
export class AlbumService {
  private _album = new BehaviorSubject<Album>({} as Album);
  private _serverAlbum = new BehaviorSubject<Album>({} as Album);
  private serverAlbum$: Observable<Album> = this._serverAlbum.asObservable();
  private _filteredFigures = new BehaviorSubject<Figure[]>([]);
  private _searchKeyword = new BehaviorSubject<string>('');
  private _loading = new BehaviorSubject<boolean>(false);

  public album$: Observable<Album> = this._album.asObservable();
  public unSavedChanges$: Observable<boolean> = combineLatest([
    this.serverAlbum$,
    this.album$,
  ]).pipe(map(([serverAlbum, album]) => Boolean(serverAlbum != album)));
  public filteredFigures$: Observable<Figure[]> =
    this._filteredFigures.asObservable();
  public searchKeyword$: Observable<string> =
    this._searchKeyword.asObservable();
  public loading$: Observable<boolean> = this._loading.asObservable();

  constructor(
    private firestore: Firestore,
    private notificationService: NotificationsService
  ) {}

  /**
   * Creates a new album for a specific user
   * @param userId user id of the albumcreator
   * @param name album name given bu the user
   */
  private async createNewAlbum(userId: string, name: string): Promise<Album> {
    const key = this.generateId();
    const newAlbum = generateNewAlbum(userId, name, key);
    try {
      await setDoc(
        doc(this.firestore, FirestoreCollections.ALBUMS, key),
        newAlbum
      );
      this.notificationService.showSuccess(
        '✅ Nuevo album creado con éxito',
        'Yey!'
      );

      return newAlbum;
    } catch (error) {
      this.notificationService.showError('📛 Error creating new album', 'Ouch');
      return {} as Album;
    }
  }

  /**
   * Get the album of a specific user from the server or generate a new one for not loggedin users
   * @param userId user id of the albumcreator
   */
  async getUserAlbum(userId: string = ''): Promise<void> {
    this._loading.next(true);
    let album = {} as Album;
    if (userId > '') {
      const albumsRef = collection(this.firestore, FirestoreCollections.ALBUMS);
      const userAlbumsQuery = query(albumsRef, where('owner', '==', userId));
      const albumsSnapshot = await getDocs(userAlbumsQuery);
      if (albumsSnapshot) {
        album = albumsSnapshot.empty
          ? await this.createNewAlbum(userId, 'Mi álbum')
          : albumsSnapshot.docs.map((doc) => doc.data() as Album)[0];
        this._serverAlbum.next(album);
        if (this.totalFiguresCompleted(album) !== 0) {
          this._album.next(album);
          this._filteredFigures.next(album.figures);
        } else {
          this._album.next({
            ...album,
            figures: this._album.getValue().figures ?? album.figures,
          } as Album);
          this._filteredFigures.next(this._album.getValue().figures);
        }
      } else {
        this.notificationService.showError(
          '😬 Ocurrió un error cargando la información. Por favor refresca la página.',
          'OK'
        );
      }
    } else {
      album = generateNewAlbum('visitor', `Visitor's album`, this.generateId());
      this._serverAlbum.next({} as Album);
      this._album.next(album);
      this._filteredFigures.next(album.figures);
    }
    this._loading.next(false);
  }

  /**
   * Toggle the state of a figure in the album
   * @param album album to be edited
   * @param figure to be toggled
   */
  toggleFigureState(album: Album, figure: Figure): void {
    const figureIndex = album.figures.indexOf(figure);
    if (figureIndex > -1) {
      const newFigure = { ...figure, checked: !figure.checked };
      album.figures[figureIndex] = newFigure;
      const newAlbum = { ...album, figures: [...album.figures] };
      this._album.next(newAlbum);
      this.filterFigures(this._searchKeyword.getValue());
    }
  }

  /**
   * Save the current client album to the server
   */
  saveAlbum(): void {
    this._loading.next(true);
    const serverAlbum = this._serverAlbum.getValue();
    const localAlbum = this._album.getValue();
    const newServerAlbum = {
      ...serverAlbum,
      dates: { ...serverAlbum.dates, lastUpdate: new Date().getTime() },
      figures: localAlbum.figures,
    };
    updateDoc(
      doc(this.firestore, FirestoreCollections.ALBUMS, serverAlbum.key),
      newServerAlbum as DocumentData
    )
      .then(() => {
        this.notificationService.showSuccess(
          '✅ Album actualizado con éxito',
          'Yey!'
        );
        this._serverAlbum.next(newServerAlbum);
        this._album.next(newServerAlbum);
        this.filterFigures(this._searchKeyword.getValue());
        this._loading.next(false);
      })
      .catch((error: Error) => {
        this.notificationService.showError(
          '📛 Algo pasó, por favor intenta guardar nuevamente los cambios.',
          'Ouch'
        );
        console.log(
          '📛 Algo pasó, por favor intenta guardar nuevamente los cambios.',
          error
        );
        this._loading.next(false);
      });
  }

  private generateId(): string {
    const chars =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    let autoId = '';
    for (let i = 0; i < 20; i++) {
      autoId += chars.charAt(Math.floor(Math.random() * chars.length));
    }
    return autoId;
  }

  filterFigures(keyword: string) {
    this._searchKeyword.next(keyword);
    const album = this._album.getValue();
    const filteredFigures = album.figures.filter((figure) => {
      return figure.prefix.toUpperCase().includes(keyword.toUpperCase());
    });
    this._filteredFigures.next(filteredFigures);
  }

  totalFigures(album: Album): number {
    return album?.figures?.length ?? 0;
  }

  totalFiguresCompleted(album: Album): number {
    return (
      album?.figures?.filter((figure) => figure.checked === true).length ?? 0
    );
  }

  totalEmblemFigures(album: Album): number {
    return (
      album?.figures?.filter(
        (figure) => figure.category === FigureCategory.EMBLEM
      ).length ?? 0
    );
  }

  totalEmblemFiguresCompleted(album: Album): number {
    return (
      album?.figures?.filter(
        (figure) =>
          figure.category === FigureCategory.EMBLEM && figure.checked === true
      ).length ?? 0
    );
  }

  totalFifaFigures(album: Album): number {
    return (
      album?.figures?.filter(
        (figure) => figure.category === FigureCategory.FIFA_MUSEUM
      ).length ?? 0
    );
  }

  totalFifaiguresCompleted(album: Album): number {
    return (
      album?.figures?.filter(
        (figure) =>
          figure.category === FigureCategory.FIFA_MUSEUM &&
          figure.checked === true
      ).length ?? 0
    );
  }
  totalBelieversFigures(album: Album): number {
    return (
      album?.figures?.filter(
        (figure) => figure.category === FigureCategory.TEAM_BELIEVERS
      ).length ?? 0
    );
  }

  totalBelieversFiguresCompleted(album: Album): number {
    return (
      album?.figures?.filter(
        (figure) =>
          figure.category === FigureCategory.TEAM_BELIEVERS &&
          figure.checked === true
      ).length ?? 0
    );
  }
  totalStadiumFigures(album: Album): number {
    return (
      album?.figures?.filter(
        (figure) => figure.category === FigureCategory.STADIUM
      ).length ?? 0
    );
  }

  totalStadiumFiguresCompleted(album: Album): number {
    return (
      album?.figures?.filter(
        (figure) =>
          figure.category === FigureCategory.STADIUM && figure.checked === true
      ).length ?? 0
    );
  }
  totalTeamEmblemFigures(album: Album): number {
    return (
      album?.figures?.filter((figure) => figure.type === FigureType.EMBLEM)
        .length ?? 0
    );
  }

  totalTeamEmblemFiguresCompleted(album: Album): number {
    return (
      album?.figures?.filter(
        (figure) => figure.type === FigureType.EMBLEM && figure.checked === true
      ).length ?? 0
    );
  }
  totalPlayersFigures(album: Album): number {
    return (
      album?.figures?.filter((figure) => figure.type === FigureType.PLAYER)
        .length ?? 0
    );
  }

  totalPlayersFiguresCompleted(album: Album): number {
    return (
      album?.figures?.filter(
        (figure) => figure.type === FigureType.PLAYER && figure.checked === true
      ).length ?? 0
    );
  }

  async convertToBrazilianAlbum(album: Album): Promise<Album> {
    const currentFigures = album.figures;
    const brazilianFigures = currentFigures;
    const countries = [
      { cat: FigureCategory.GROUP_A, prefix: FigurePrefix.QAT },
      { cat: FigureCategory.GROUP_A, prefix: FigurePrefix.ECU },
      { cat: FigureCategory.GROUP_A, prefix: FigurePrefix.SEN },
      { cat: FigureCategory.GROUP_A, prefix: FigurePrefix.NED },
      { cat: FigureCategory.GROUP_B, prefix: FigurePrefix.ENG },
      { cat: FigureCategory.GROUP_B, prefix: FigurePrefix.IRN },
      { cat: FigureCategory.GROUP_B, prefix: FigurePrefix.USA },
      { cat: FigureCategory.GROUP_B, prefix: FigurePrefix.WAL },
      { cat: FigureCategory.GROUP_C, prefix: FigurePrefix.ARG },
      { cat: FigureCategory.GROUP_C, prefix: FigurePrefix.KSA },
      { cat: FigureCategory.GROUP_C, prefix: FigurePrefix.MEX },
      { cat: FigureCategory.GROUP_C, prefix: FigurePrefix.POL },
      { cat: FigureCategory.GROUP_D, prefix: FigurePrefix.FRA },
      { cat: FigureCategory.GROUP_D, prefix: FigurePrefix.AUS },
      { cat: FigureCategory.GROUP_D, prefix: FigurePrefix.DEN },
      { cat: FigureCategory.GROUP_D, prefix: FigurePrefix.TUN },
      { cat: FigureCategory.GROUP_E, prefix: FigurePrefix.ESP },
      { cat: FigureCategory.GROUP_E, prefix: FigurePrefix.CRC },
      { cat: FigureCategory.GROUP_E, prefix: FigurePrefix.GER },
      { cat: FigureCategory.GROUP_E, prefix: FigurePrefix.JPN },
      { cat: FigureCategory.GROUP_F, prefix: FigurePrefix.BEL },
      { cat: FigureCategory.GROUP_F, prefix: FigurePrefix.CAN },
      { cat: FigureCategory.GROUP_F, prefix: FigurePrefix.MAR },
      { cat: FigureCategory.GROUP_F, prefix: FigurePrefix.CRO },
      { cat: FigureCategory.GROUP_G, prefix: FigurePrefix.BRA },
      { cat: FigureCategory.GROUP_G, prefix: FigurePrefix.SRB },
      { cat: FigureCategory.GROUP_G, prefix: FigurePrefix.SUI },
      { cat: FigureCategory.GROUP_G, prefix: FigurePrefix.CMR },
      { cat: FigureCategory.GROUP_H, prefix: FigurePrefix.POR },
      { cat: FigureCategory.GROUP_H, prefix: FigurePrefix.GHA },
      { cat: FigureCategory.GROUP_H, prefix: FigurePrefix.URU },
      { cat: FigureCategory.GROUP_H, prefix: FigurePrefix.KOR },
    ];

    countries.forEach((country) => {
      const lastTeamIndex = currentFigures.findIndex(
        (figure) => figure.prefix === country.prefix && figure.number === 19
      );
      const colombianShieldIndex = currentFigures.findIndex(
        (figure) => figure.prefix === country.prefix && figure.number === 1
      );
      const brazilianShieldIndex = currentFigures.findIndex(
        (figure) => figure.prefix === country.prefix && figure.number === 2
      );
      brazilianFigures[colombianShieldIndex].type = FigureType.TEAM;
      brazilianFigures[brazilianShieldIndex].type = FigureType.EMBLEM;
      const newFigure = {
        section: FigureSection.TEAM,
        checked: false,
        category: country.cat,
        prefix: country.prefix,
        type: FigureType.PLAYER,
        number: 20,
      };
      // Add new figure to array
      brazilianFigures.splice(lastTeamIndex + 1, 0, newFigure);
    });
    const newAlbum = { ...album, figures: brazilianFigures };
    try {
      await setDoc(
        doc(this.firestore, FirestoreCollections.ALBUMS, album.key),
        newAlbum
      );
      this.notificationService.showSuccess(
        '✅ Álbum actualizado con éxito',
        'Yey!'
      );
      return newAlbum;
    } catch (error) {
      this.notificationService.showError('📛 Error updating album', 'Ouch');
      return {} as Album;
    }
  }
}
