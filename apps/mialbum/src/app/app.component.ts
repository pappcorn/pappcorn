import { Component } from '@angular/core';

@Component({
  selector: 'pappcorn-root',
  template: `<router-outlet></router-outlet>`,
  styles: [
    `
      :host {
        display: block;
        height: 100%;
      }
    `,
  ],
})
export class AppComponent {
  title = 'mialbum.co';
}
