import { Pipe, PipeTransform } from '@angular/core';
import { FigurePrefix } from '@pappcorn/mialbum/util-interfaces';

@Pipe({
  name: 'teamName',
})
export class TeamNamePipe implements PipeTransform {
  transform(value: FigurePrefix): string {
    switch (value) {
      case FigurePrefix.QAT:
        return 'Qatar';
      case FigurePrefix.ECU:
        return 'Ecuador';
      case FigurePrefix.SEN:
        return 'Senegal';
      case FigurePrefix.NED:
        return 'Holanda';
      case FigurePrefix.ENG:
        return 'Inglaterra';
      case FigurePrefix.IRN:
        return 'Irán';
      case FigurePrefix.USA:
        return 'Estados Unidos';
      case FigurePrefix.WAL:
        return 'Walles';
      case FigurePrefix.ARG:
        return 'Argentina';
      case FigurePrefix.KSA:
        return 'Arabia Saudita';
      case FigurePrefix.MEX:
        return 'México';
      case FigurePrefix.POL:
        return 'Polonia';
      case FigurePrefix.FRA:
        return 'Francia';
      case FigurePrefix.AUS:
        return 'Australia';
      case FigurePrefix.DEN:
        return 'Dinamarca';
      case FigurePrefix.TUN:
        return 'Tunez';
      case FigurePrefix.ESP:
        return 'España';
      case FigurePrefix.CRC:
        return 'Costa Rica';
      case FigurePrefix.GER:
        return 'Alemania';
      case FigurePrefix.JPN:
        return 'Japón';
      case FigurePrefix.BEL:
        return 'Bélgica';
      case FigurePrefix.CAN:
        return 'Canadá';
      case FigurePrefix.MAR:
        return 'Marruecos';
      case FigurePrefix.CRO:
        return 'Croacia';
      case FigurePrefix.BRA:
        return 'Brasil';
      case FigurePrefix.SRB:
        return 'Serbia';
      case FigurePrefix.SUI:
        return 'Suiza';
      case FigurePrefix.CMR:
        return 'Camerún';
      case FigurePrefix.POR:
        return 'Portugal';
      case FigurePrefix.GHA:
        return 'Ghana';
      case FigurePrefix.URU:
        return 'Uruguay';
      case FigurePrefix.KOR:
        return 'Korea';
      default:
        return '';
    }
  }
}
