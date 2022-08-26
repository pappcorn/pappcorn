import { ChangeDetectionStrategy, Component, OnDestroy } from '@angular/core';
import { AlbumService } from '@pappcorn/mialbum/data-album';
import { AuthService } from '@pappcorn/shared/data-auth';
import { Subject } from 'rxjs';
import { shareReplay, takeUntil, tap } from 'rxjs/operators';

@Component({
  selector: 'pappcorn-main-nav',
  templateUrl: './main-nav.component.html',
  styleUrls: ['./main-nav.component.scss'],
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class MainNavComponent implements OnDestroy {
  destroy$ = new Subject();
  subToolbarOpen = false;
  constructor(
    readonly albumService: AlbumService,
    readonly authService: AuthService
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
  }

  ngOnDestroy(): void {
    this.destroy$.complete();
  }
}
