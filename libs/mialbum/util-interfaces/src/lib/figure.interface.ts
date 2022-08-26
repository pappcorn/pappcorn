export interface Figure {
  section: FigureSection;
  checked: boolean;
  category: FigureCategory;
  type?: FigureType;
  prefix: FigurePrefix;
  number: number;
}

export enum FigureSection {
  FIFA = 'FIFA World Cup',
  TEAM = 'Equipos',
  COCA_COLA = 'Coca-Cola',
}
export enum FigureCategory {
  EMBLEM = 'Emblemas',
  STADIUM = 'Estadios',
  GROUP_A = 'Grupo A',
  GROUP_B = 'Grupo B',
  GROUP_C = 'Grupo C',
  GROUP_D = 'Grupo D',
  GROUP_E = 'Grupo E',
  GROUP_F = 'Grupo F',
  GROUP_G = 'Grupo G',
  GROUP_H = 'Grupo H',
  FIFA_MUSEUM = 'Museo FIFA',
  TEAM_BELIEVERS = 'Team Believers',
}
export enum FigureGroup {
  A = 'Gupo A',
  B = 'Gupo B',
  C = 'Gupo C',
  D = 'Gupo D',
  E = 'Gupo E',
  F = 'Gupo F',
  G = 'Gupo G',
  H = 'Gupo H',
}

export enum FigureType {
  EMBLEM = 'Escudo',
  PLAYER = 'Jugador',
}

export enum FigurePrefix {
  FWC = 'FWC',
  QAT = 'QAT',
  ECU = 'ECU',
  SEN = 'SEN',
  NED = 'NED',
  ENG = 'ENG',
  IRN = 'IRN',
  USA = 'USA',
  WAL = 'WAL',
  ARG = 'ARG',
  KSA = 'KSA',
  MEX = 'MEX',
  POL = 'POL',
  FRA = 'FRA',
  AUS = 'AUS',
  DEN = 'DEN',
  TUN = 'TUN',
  ESP = 'ESP',
  CRC = 'CRC',
  GER = 'GER',
  JPN = 'JPN',
  BEL = 'BEL',
  CAN = 'CAN',
  MAR = 'MAR',
  CRO = 'CRO',
  BRA = 'BRA',
  SRB = 'SRB',
  SUI = 'SUI',
  CMR = 'CMR',
  POR = 'POR',
  GHA = 'GHA',
  URU = 'URU',
  KOR = 'KOR',
  C = 'C',
}
