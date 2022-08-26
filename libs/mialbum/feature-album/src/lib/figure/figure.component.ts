import {
  ChangeDetectionStrategy,
  Component,
  EventEmitter,
  Input,
  OnInit,
  Output,
} from '@angular/core';
import { Figure } from '@pappcorn/mialbum/util-interfaces';

@Component({
  selector: 'pappcorn-figure',
  templateUrl: './figure.component.html',
  styleUrls: ['./figure.component.scss'],
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class FigureComponent implements OnInit {
  @Input() figure: Figure | undefined;
  @Output() toggleFigureState = new EventEmitter();
  public checked = false;

  ngOnInit(): void {
    this.checked = this.figure?.checked ?? false;
  }

  toggleFigure() {
    this.checked = !this.checked;
    this.toggleFigureState.emit();
  }
}
