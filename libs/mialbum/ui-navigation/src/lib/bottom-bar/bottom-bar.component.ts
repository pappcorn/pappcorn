import { Component, EventEmitter, Input, Output } from '@angular/core';
import { User } from '@angular/fire/auth';
import { MatBottomSheet } from '@angular/material/bottom-sheet';
import { AuthService } from '@pappcorn/shared/data-auth';
import { BottomSheetLoginComponent } from '../bottom-sheet-login/bottom-sheet-login.component';

@Component({
  selector: 'pappcorn-bottom-bar',
  templateUrl: './bottom-bar.component.html',
  styleUrls: ['./bottom-bar.component.scss'],
})
export class BottomBarComponent {
  @Input() user: User | null = null;
  @Output() saveChanges = new EventEmitter();

  constructor(
    protected readonly authService: AuthService,
    private _bottomSheet: MatBottomSheet
  ) {}

  openBottomSheet(): void {
    this._bottomSheet.open(BottomSheetLoginComponent);
  }
}
