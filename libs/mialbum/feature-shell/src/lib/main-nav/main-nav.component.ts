import { ChangeDetectionStrategy, Component, OnDestroy } from '@angular/core';
import { MatSnackBar } from '@angular/material/snack-bar';
import { AlbumService } from '@pappcorn/mialbum/data-album';
import { AuthService, NotificationsService } from '@pappcorn/shared/data-auth';
import { Subject } from 'rxjs';
import { filter, shareReplay, takeUntil, tap } from 'rxjs/operators';

@Component({
  selector: 'pappcorn-main-nav',
  templateUrl: './main-nav.component.html',
  styleUrls: ['./main-nav.component.scss'],
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class MainNavComponent implements OnDestroy {
  destroy$ = new Subject();
  subToolbarOpen = true;
  constructor(
    readonly albumService: AlbumService,
    readonly authService: AuthService,
    readonly notificationsService: NotificationsService,
    private _snackBar: MatSnackBar
  ) {
    this.authService.user$
      .pipe(
        takeUntil(this.destroy$),
        tap((user) => {
          if (user) {
            this.albumService.getUserAlbum(user.uid);
          } else {
            this.albumService.getUserAlbum();
          }
        }),
        shareReplay()
      )
      .subscribe();

    this.notificationsService.notify$
      .pipe(
        takeUntil(this.destroy$),
        filter((notification) => notification.message > ''),
        tap((notification) =>
          this.openSnackBar(
            notification.message,
            notification.action,
            notification.duration
          )
        )
      )
      .subscribe();
  }

  ngOnDestroy(): void {
    this.destroy$.complete();
  }

  openSnackBar(
    message: string,
    action: string = 'OK',
    duration: number = 3000
  ) {
    this._snackBar.open(message, action, {
      duration,
    });
  }
}
