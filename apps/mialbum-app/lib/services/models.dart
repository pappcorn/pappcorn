// ignore_for_file: constant_identifier_names

import 'package:json_annotation/json_annotation.dart';
part 'models.g.dart';

@JsonSerializable()
class Figure {
  String section;
  bool checked;
  String category;
  String? type;
  String prefix;
  num number;
  Figure({
    this.section = FigureSection.FIFA,
    this.checked = false,
    this.category = FigureCategory.EMBLEM,
    this.type,
    this.prefix = FigurePrefix.FWC,
    this.number = 0,
  });
  factory Figure.fromJson(Map<String, dynamic> json) => _$FigureFromJson(json);
  Map<String, dynamic> toJson() => _$FigureToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Album {
  Map<String, int> dates;
  Map<String, String> managers;
  String name;
  String owner;
  String key;
  List<Figure> figures;

  Album({
    this.dates = const {},
    this.managers = const {"uid": OwnerRol.CREATOR},
    this.name = '',
    this.owner = '',
    this.key = '',
    this.figures = const [],
  });
  factory Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);
  Map<String, dynamic> toJson() => _$AlbumToJson(this);
}

@JsonSerializable()
class AlbumDates {
  final int start;
  final int lastUpdate;
  final int end;

  AlbumDates({
    this.start = 0,
    this.lastUpdate = 0,
    this.end = 0,
  });
  factory AlbumDates.fromJson(Map<String, dynamic> json) =>
      _$AlbumDatesFromJson(json);
  Map<String, dynamic> toJson() => _$AlbumDatesToJson(this);
}

class FigureSection {
  static const FIFA = 'FIFA World Cup';
  static const TEAM = 'Equipos';
  static const COCA_COLA = 'Coca-Cola';
}

class FigureType {
  static const SHIELD = 'Escudo';
  static const PLAYER = 'Jugador';
}

class FigureCategory {
  static const EMBLEM = 'Emblemas';
  static const STADIUM = 'Estadios';
  static const GROUP_A = 'Grupo A';
  static const GROUP_B = 'Grupo B';
  static const GROUP_C = 'Grupo C';
  static const GROUP_D = 'Grupo D';

  static const GROUP_E = 'Grupo E';
  static const GROUP_F = 'Grupo F';
  static const GROUP_G = 'Grupo G';
  static const GROUP_H = 'Grupo H';
  static const FIFA_MUSEUM = 'Museo FIFA';
  static const TEAM_BELIEVERS = 'Team Believers';
}

class FigurePrefix {
  static const FWC = 'FWC';
  static const QAT = 'QAT';
  static const ECU = 'ECU';
  static const SEN = 'SEN';
  static const NED = 'NED';
  static const ENG = 'ENG';
  static const IRN = 'IRN';
  static const USA = 'USA';
  static const WAL = 'WAL';
  static const ARG = 'ARG';
  static const KSA = 'KSA';
  static const MEX = 'MEX';
  static const POL = 'POL';
  static const FRA = 'FRA';
  static const AUS = 'AUS';
  static const DEN = 'DEN';
  static const TUN = 'TUN';
  static const ESP = 'ESP';
  static const CRC = 'CRC';
  static const GER = 'GER';
  static const JPN = 'JPN';
  static const BEL = 'BEL';
  static const CAN = 'CAN';
  static const MAR = 'MAR';
  static const CRO = 'CRO';
  static const BRA = 'BRA';
  static const SRB = 'SRB';
  static const SUI = 'SUI';
  static const CMR = 'CMR';
  static const POR = 'POR';
  static const GHA = 'GHA';
  static const URU = 'URU';
  static const KOR = 'KOR';
  static const C = 'C';
}

class OwnerRol {
  static const ADMIN = 'amdin';
  static const VIEWER = 'viewer';
  static const CREATOR = 'creator';
}

class FirestoreCollections {
  static const ALBUMS = 'albums';
}
