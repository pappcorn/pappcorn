import { ChangeDetectionStrategy, Component } from '@angular/core';
import { FormControl } from '@angular/forms';
import { AlbumService } from '@pappcorn/mialbum/data-album';
import {
  Album,
  Figure,
  FigureCategory,
  FigurePrefix,
  FigureSection,
} from '@pappcorn/mialbum/util-interfaces';
import { AuthService } from '@pappcorn/shared/data-auth';
import { BehaviorSubject } from 'rxjs';

@Component({
  selector: 'pappcorn-album',
  templateUrl: './album.component.html',
  styleUrls: ['./album.component.scss'],
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class AlbumComponent {
  readonly sections = Object.values(FigureSection).map((section) => section);
  readonly categories = Object.values(FigureCategory).map(
    (category) => category
  );
  readonly prefixes = Object.values(FigurePrefix).map((prefix) => prefix);
  readonly FigurePrefix = FigurePrefix;

  protected readonly album$ = this.albumService.album$;

  private _filteredFifures = new BehaviorSubject<Figure[]>([] as Figure[]);
  readonly filteredFigures$ = this._filteredFifures.asObservable();

  protected searchInput = new FormControl<string>('');

  constructor(
    public albumService: AlbumService,
    public authService: AuthService
  ) {}

  getCategorizedFigures(
    figures: Figure[] | null,
    section: FigureSection,
    category: FigureCategory,
    prefix: FigurePrefix
  ): Figure[] {
    return figures
      ? figures.filter(
          (figure) =>
            figure.section === section &&
            figure.category === category &&
            figure.prefix === prefix
        )
      : [];
  }
  toggleFigureState(album: Album, figure: Figure): void {
    this.albumService.toggleFigureState(album, figure);
  }

  // filterFigures(keyword: string, figures: Figure[]): Figure[] {
  filterFigures(k: any) {
    console.log(k);
    // return figures.filter((figure) => figure.prefix.includes(keyword));
  }

  convertAlbum(album: Album): void {
    this.albumService.convertToBrazilianAlbum(album);
  }
}
