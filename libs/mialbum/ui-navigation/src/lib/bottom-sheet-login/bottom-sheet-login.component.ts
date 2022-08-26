import { ChangeDetectionStrategy, Component } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { MatBottomSheetRef } from '@angular/material/bottom-sheet';
import { AuthService } from '@pappcorn/shared/data-auth';

@Component({
  selector: 'pappcorn-bottom-sheet-login',
  templateUrl: './bottom-sheet-login.component.html',
  styleUrls: ['./bottom-sheet-login.component.scss'],
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class BottomSheetLoginComponent {
  protected showCreateAccount = false;
  protected showLogin = false;

  loginForm = new FormGroup({
    email: new FormControl<string>('', {
      nonNullable: true,
      validators: [Validators.required, Validators.email],
    }),
    password: new FormControl<string>('', {
      nonNullable: true,
      validators: [Validators.required, Validators.minLength(8)],
    }),
  });
  createAccountForm = new FormGroup({
    email: new FormControl<string>('', {
      nonNullable: true,
      validators: [Validators.required, Validators.email],
    }),
    password: new FormControl<string>('', {
      nonNullable: true,
      validators: [Validators.required, Validators.minLength(8)],
    }),
    name: new FormControl<string>('', {
      nonNullable: true,
      validators: [Validators.required],
    }),
  });
  acceptTerms = false;

  constructor(
    private _bottomSheetRef: MatBottomSheetRef<BottomSheetLoginComponent>,
    protected readonly authService: AuthService
  ) {}

  openLink(event: MouseEvent): void {
    this._bottomSheetRef.dismiss();
    event.preventDefault();
  }
}
