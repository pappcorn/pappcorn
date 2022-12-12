// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Figure _$FigureFromJson(Map<String, dynamic> json) => Figure(
      section: json['section'] as String? ?? FigureSection.FIFA,
      checked: json['checked'] as bool? ?? false,
      category: json['category'] as String? ?? FigureCategory.EMBLEM,
      type: json['type'] as String?,
      prefix: json['prefix'] as String? ?? FigurePrefix.FWC,
      number: json['number'] as num? ?? 0,
    );

Map<String, dynamic> _$FigureToJson(Figure instance) => <String, dynamic>{
      'section': instance.section,
      'checked': instance.checked,
      'category': instance.category,
      'type': instance.type,
      'prefix': instance.prefix,
      'number': instance.number,
    };

Album _$AlbumFromJson(Map<String, dynamic> json) => Album(
      dates: (json['dates'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as int),
          ) ??
          const {},
      managers: (json['managers'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {"uid": OwnerRol.CREATOR},
      name: json['name'] as String? ?? '',
      owner: json['owner'] as String? ?? '',
      key: json['key'] as String? ?? '',
      figures: (json['figures'] as List<dynamic>?)
              ?.map((e) => Figure.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$AlbumToJson(Album instance) => <String, dynamic>{
      'dates': instance.dates,
      'managers': instance.managers,
      'name': instance.name,
      'owner': instance.owner,
      'key': instance.key,
      'figures': instance.figures.map((e) => e.toJson()).toList(),
    };

AlbumDates _$AlbumDatesFromJson(Map<String, dynamic> json) => AlbumDates(
      start: json['start'] as int? ?? 0,
      lastUpdate: json['lastUpdate'] as int? ?? 0,
      end: json['end'] as int? ?? 0,
    );

Map<String, dynamic> _$AlbumDatesToJson(AlbumDates instance) =>
    <String, dynamic>{
      'start': instance.start,
      'lastUpdate': instance.lastUpdate,
      'end': instance.end,
    };
