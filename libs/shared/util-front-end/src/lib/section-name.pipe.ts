import { Pipe, PipeTransform } from '@angular/core';
import { FigureSection } from '@pappcorn/mialbum/util-interfaces';

@Pipe({
  name: 'sectionName',
})
export class SectionNamePipe implements PipeTransform {
  transform(section: FigureSection): string {
    switch (section) {
      case FigureSection.FIFA:
        return 'FWC';
      case FigureSection.COCA_COLA:
        return 'CC';
      default:
        return section;
    }
  }
}
