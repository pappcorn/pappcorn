import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { AngularFirestoreModule } from '@angular/fire/compat/firestore';
import { MatSnackBarModule } from '@angular/material/snack-bar';
import { AlbumService } from './album.service';

@NgModule({
  imports: [CommonModule, MatSnackBarModule],
  providers: [AngularFirestoreModule, AlbumService],
})
export class MialbumDataAlbumModule {}
