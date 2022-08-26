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
  FigureType,
  FirestoreCollections,
} from '@pappcorn/mialbum/util-interfaces';
import { BehaviorSubject, combineLatest, map, Observable, tap } from 'rxjs';
import { generateNewAlbum } from './new-album.generator';

@Injectable({
  providedIn: 'root',
})
export class AlbumService {
  private _album = new BehaviorSubject<Album>({} as Album);
  private _serverAlbum = new BehaviorSubject<Album>({} as Album);
  private serverAlbum$: Observable<Album> = this._serverAlbum.asObservable();

  public album$: Observable<Album> = this._album.asObservable();
  public unSavedChanges$: Observable<boolean> = combineLatest([
    this.serverAlbum$,
    this.album$,
  ]).pipe(map(([serverAlbum, album]) => Boolean(serverAlbum != album)));

  constructor(private firestore: Firestore) {}

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
      console.log('✅ New album created', newAlbum.key);
      return newAlbum;
    } catch (error) {
      console.log('📛 Error creating new album', newAlbum, error);
      return {} as Album;
    }
  }

  /**
   * Get the album of a specific user from the server or generate a new one for not loggedin users
   * @param userId user id of the albumcreator
   */
  async getUserAlbum(userId: string = ''): Promise<void> {
    let album = {} as Album;
    if (userId > '') {
      const albumsRef = collection(this.firestore, FirestoreCollections.ALBUMS);
      const userAlbumsQuery = query(albumsRef, where('owner', '==', userId));
      const albumsSnapshot = await getDocs(userAlbumsQuery);
      album = albumsSnapshot.empty
        ? await this.createNewAlbum(userId, 'Mi álbum')
        : albumsSnapshot.docs.map((doc) => doc.data() as Album)[0];
      this._serverAlbum.next(album);
      if (this.totalFiguresCompleted(album) !== 0) {
        this._album.next(album);
      } else {
        this._album.next({
          ...album,
          figures: this._album.getValue().figures,
        } as Album);
      }
    } else {
      album = generateNewAlbum('visitor', `Visitor's album`, this.generateId());
      this._serverAlbum.next({} as Album);
      this._album.next(album);
    }
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
    }
  }

  /**
   * Save the current client album to the server
   */
  saveAlbum(): void {
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
      .then((snap) => {
        console.log('✅ Album actualizado con éxito', snap);
        this._serverAlbum.next(newServerAlbum);
        this._album.next(newServerAlbum);
      })
      .catch((error: Error) =>
        console.log(
          '📛 Algo pasó, por favor intenta guardar nuevamente los cambios.',
          error
        )
      );
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
}
