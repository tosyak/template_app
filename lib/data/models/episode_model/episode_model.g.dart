// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episode_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EpisodeModel _$EpisodeModelFromJson(Map<String, dynamic> json) =>
    _EpisodeModel(
      id: json['id'] as String,
      name: json['name'] as String,
      airDate: json['air_date'] as String,
      episode: json['episode'] as String,
      created: DateTime.parse(json['created'] as String),
    );

Map<String, dynamic> _$EpisodeModelToJson(_EpisodeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'air_date': instance.airDate,
      'episode': instance.episode,
      'created': instance.created.toIso8601String(),
    };

_EpisodeResponseModel _$EpisodeResponseModelFromJson(
        Map<String, dynamic> json) =>
    _EpisodeResponseModel(
      info: GraphQLInfoModel.fromJson(json['info'] as Map<String, dynamic>),
      results: (json['results'] as List<dynamic>)
          .map((e) => EpisodeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EpisodeResponseModelToJson(
        _EpisodeResponseModel instance) =>
    <String, dynamic>{
      'info': instance.info,
      'results': instance.results,
    };
