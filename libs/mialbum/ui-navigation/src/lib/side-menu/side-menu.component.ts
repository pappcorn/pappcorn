import { Component, EventEmitter, Input, Output } from '@angular/core';
import { User } from '@angular/fire/auth';
import { MatBottomSheet } from '@angular/material/bottom-sheet';
import {
  Album,
  FigureCategory,
  FigureType,
} from '@pappcorn/mialbum/util-interfaces';
import { BottomSheetLoginComponent } from '../bottom-sheet-login/bottom-sheet-login.component';

@Component({
  selector: 'pappcorn-side-menu',
  templateUrl: './side-menu.component.html',
  styleUrls: ['./side-menu.component.scss'],
})
export class SideMenuComponent {
  @Input() user: User | null = null;
  @Input() album: Album | null = null;
  @Output() logout = new EventEmitter();

  constructor(private _bottomSheet: MatBottomSheet) {}

  openBottomSheet(): void {
    this._bottomSheet.open(BottomSheetLoginComponent);
  }

  totalFigures(): number {
    return this.album?.figures?.length ?? 0;
  }

  totalFiguresCompleted(): number {
    return (
      this.album?.figures?.filter((figure) => figure.checked === true).length ??
      0
    );
  }

  totalEmblemFigures(): number {
    return (
      this.album?.figures?.filter(
        (figure) => figure.category === FigureCategory.EMBLEM
      ).length ?? 0
    );
  }

  totalEmblemFiguresCompleted(): number {
    return (
      this.album?.figures?.filter(
        (figure) =>
          figure.category === FigureCategory.EMBLEM && figure.checked === true
      ).length ?? 0
    );
  }

  totalFifaFigures(): number {
    return (
      this.album?.figures?.filter(
        (figure) => figure.category === FigureCategory.FIFA_MUSEUM
      ).length ?? 0
    );
  }

  totalFifaiguresCompleted(): number {
    return (
      this.album?.figures?.filter(
        (figure) =>
          figure.category === FigureCategory.FIFA_MUSEUM &&
          figure.checked === true
      ).length ?? 0
    );
  }
  totalBelieversFigures(): number {
    return (
      this.album?.figures?.filter(
        (figure) => figure.category === FigureCategory.TEAM_BELIEVERS
      ).length ?? 0
    );
  }

  totalBelieversFiguresCompleted(): number {
    return (
      this.album?.figures?.filter(
        (figure) =>
          figure.category === FigureCategory.TEAM_BELIEVERS &&
          figure.checked === true
      ).length ?? 0
    );
  }
  totalStadiumFigures(): number {
    return (
      this.album?.figures?.filter(
        (figure) => figure.category === FigureCategory.STADIUM
      ).length ?? 0
    );
  }

  totalStadiumFiguresCompleted(): number {
    return (
      this.album?.figures?.filter(
        (figure) =>
          figure.category === FigureCategory.STADIUM && figure.checked === true
      ).length ?? 0
    );
  }
  totalTeamEmblemFigures(): number {
    return (
      this.album?.figures?.filter((figure) => figure.type === FigureType.EMBLEM)
        .length ?? 0
    );
  }

  totalTeamEmblemFiguresCompleted(): number {
    return (
      this.album?.figures?.filter(
        (figure) => figure.type === FigureType.EMBLEM && figure.checked === true
      ).length ?? 0
    );
  }
  totalPlayersFigures(): number {
    return (
      this.album?.figures?.filter((figure) => figure.type === FigureType.PLAYER)
        .length ?? 0
    );
  }

  totalPlayersFiguresCompleted(): number {
    return (
      this.album?.figures?.filter(
        (figure) => figure.type === FigureType.PLAYER && figure.checked === true
      ).length ?? 0
    );
  }
}
