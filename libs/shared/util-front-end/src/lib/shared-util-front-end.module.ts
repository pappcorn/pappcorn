import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FlexLayoutModule } from '@angular/flex-layout';
import { NgMaterialModule } from './ng-material/ng-material.module';
import { TeamNamePipe } from './team-name.pipe';

const sharedModules = [FlexLayoutModule, NgMaterialModule];
@NgModule({
  imports: [CommonModule, sharedModules],
  exports: [sharedModules, TeamNamePipe],
  declarations: [TeamNamePipe],
})
export class SharedUtilFrontEndModule {}
