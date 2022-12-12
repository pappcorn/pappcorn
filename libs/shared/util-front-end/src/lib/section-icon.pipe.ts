import { Pipe, PipeTransform } from '@angular/core';
import {
  FigureCategory,
  FigurePrefix,
} from '@pappcorn/mialbum/util-interfaces';

@Pipe({
  name: 'sectionIcon',
})
export class SectionIconPipe implements PipeTransform {
  transform(prefix: FigurePrefix, category: FigureCategory): string {
    if (prefix === FigurePrefix.FWC) {
      if (category === FigureCategory.STADIUM) {
        return 'STADIUM';
      } else if (category === FigureCategory.FIFA_MUSEUM) {
        return 'MUSEUM';
      } else {
        return '';
      }
    } else {
      return prefix;
    }
  }
}
