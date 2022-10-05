import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'replace',
})
export class ReplacePipe implements PipeTransform {
  transform(value: any, strToReplace: string, replacementStr: string): string {
    if (value.length === 0) {
      return value;
    }

    return value.replace(strToReplace, replacementStr);
  }
}
