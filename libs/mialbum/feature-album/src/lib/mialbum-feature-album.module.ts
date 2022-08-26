import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';
import { AlbumComponent } from './album/album.component';
import { SharedUtilFrontEndModule } from '@pappcorn/ui';
import { MialbumUiNavigationModule } from '@pappcorn/mialbum/ui-navigation';
import { FigureComponent } from './figure/figure.component';

@NgModule({
  imports: [
    CommonModule,
    RouterModule.forChild([
      { path: '', pathMatch: 'full', component: AlbumComponent },
    ]),
    SharedUtilFrontEndModule,
    MialbumUiNavigationModule,
  ],
  declarations: [AlbumComponent, FigureComponent],
})
export class MialbumFeatureAlbumModule {}
