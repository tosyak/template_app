// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_InfoModel _$InfoModelFromJson(Map<String, dynamic> json) => _InfoModel(
      count: (json['count'] as num).toInt(),
      pages: (json['pages'] as num).toInt(),
      next: json['next'] as String?,
      prev: json['prev'] as String?,
    );

Map<String, dynamic> _$InfoModelToJson(_InfoModel instance) =>
    <String, dynamic>{
      'count': instance.count,
      'pages': instance.pages,
      'next': instance.next,
      'prev': instance.prev,
    };

_GraphQLInfoModel _$GraphQLInfoModelFromJson(Map<String, dynamic> json) =>
    _GraphQLInfoModel(
      count: (json['count'] as num).toInt(),
      pages: (json['pages'] as num).toInt(),
      next: (json['next'] as num?)?.toInt(),
      prev: (json['prev'] as num?)?.toInt(),
    );

Map<String, dynamic> _$GraphQLInfoModelToJson(_GraphQLInfoModel instance) =>
    <String, dynamic>{
      'count': instance.count,
      'pages': instance.pages,
      'next': instance.next,
      'prev': instance.prev,
    };
