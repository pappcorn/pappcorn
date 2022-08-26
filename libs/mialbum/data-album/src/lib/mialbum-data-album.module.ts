import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { AngularFirestoreModule } from '@angular/fire/compat/firestore';
import { AlbumService } from './album.service';

@NgModule({
  imports: [CommonModule],
  providers: [AngularFirestoreModule, AlbumService],
})
export class MialbumDataAlbumModule {}
