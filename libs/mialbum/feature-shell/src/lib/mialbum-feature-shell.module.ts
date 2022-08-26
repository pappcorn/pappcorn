import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { RouterModule } from '@angular/router';
import { MialbumUiNavigationModule } from '@pappcorn/mialbum/ui-navigation';
import { SharedUtilFrontEndModule } from '@pappcorn/ui';
import { MainNavComponent } from './main-nav/main-nav.component';

@NgModule({
  imports: [
    CommonModule,
    RouterModule.forChild([
      {
        path: '',
        component: MainNavComponent,
        children: [
          {
            path: '',
            loadChildren: () =>
              import('@pappcorn/mialbum/feature-album').then(
                (m) => m.MialbumFeatureAlbumModule
              ),
          },
        ],
      },
    ]),
    MialbumUiNavigationModule,
    SharedUtilFrontEndModule,
  ],
  declarations: [MainNavComponent],
})
export class MialbumFeatureShellModule {}
