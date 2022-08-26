import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { SharedUtilFrontEndModule } from '@pappcorn/ui';
import { BottomBarComponent } from './bottom-bar/bottom-bar.component';
import { BottomSheetLoginComponent } from './bottom-sheet-login/bottom-sheet-login.component';
import { SideMenuComponent } from './side-menu/side-menu.component';
import { ToolbarWebComponent } from './toolbar-web/toolbar-web.component';

const pappMoodules = [
  ToolbarWebComponent,
  SideMenuComponent,
  BottomBarComponent,
  BottomSheetLoginComponent,
];

@NgModule({
  imports: [
    CommonModule,
    SharedUtilFrontEndModule,
    ReactiveFormsModule,
    FormsModule,
  ],
  declarations: [pappMoodules],
  exports: [pappMoodules],
})
export class MialbumUiNavigationModule {}
