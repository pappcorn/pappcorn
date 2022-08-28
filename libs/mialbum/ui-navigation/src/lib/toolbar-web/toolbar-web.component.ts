import {
  ChangeDetectionStrategy,
  Component,
  EventEmitter,
  Input,
  Output,
} from '@angular/core';

@Component({
  selector: 'pappcorn-toolbar-web',
  templateUrl: './toolbar-web.component.html',
  styleUrls: ['./toolbar-web.component.scss'],
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class ToolbarWebComponent {
  @Input() searchKeyword: string | null = '';
  @Output() public toggleSidenav = new EventEmitter();
  @Output() public toggleSubtoolbar = new EventEmitter();
  @Output() public searchInput = new EventEmitter<string>();
  protected showFilters = true;
  _toggleSubtoolbar() {
    this.toggleSubtoolbar.emit();
    this.showFilters = !this.showFilters;
  }
}
