import {
  ChangeDetectionStrategy,
  Component,
  EventEmitter,
  Output,
} from '@angular/core';

@Component({
  selector: 'pappcorn-toolbar-web',
  templateUrl: './toolbar-web.component.html',
  styleUrls: ['./toolbar-web.component.scss'],
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class ToolbarWebComponent {
  @Output() public toggleSidenav = new EventEmitter();
  @Output() public toggleSubtoolbar = new EventEmitter();
  protected showFilters = false;
  _toggleSubtoolbar() {
    this.toggleSubtoolbar.emit();
    this.showFilters = !this.showFilters;
  }
}
