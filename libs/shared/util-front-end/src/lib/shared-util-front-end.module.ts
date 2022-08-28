import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FlexLayoutModule } from '@angular/flex-layout';
import { NgMaterialModule } from './ng-material/ng-material.module';
import { SectionIconPipe } from './section-icon.pipe';
import { SectionNamePipe } from './section-name.pipe';
import { TeamNamePipe } from './team-name.pipe';

const sharedModules = [FlexLayoutModule, NgMaterialModule];
@NgModule({
  imports: [CommonModule, sharedModules],
  declarations: [TeamNamePipe, SectionNamePipe, SectionIconPipe],
  exports: [sharedModules, TeamNamePipe, SectionNamePipe, SectionIconPipe],
})
export class SharedUtilFrontEndModule {}
