import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ricknotmorty/data/models/info_model/info_model.dart';
import 'package:ricknotmorty/data/models/location_model/location_model.dart';

part 'character_model.freezed.dart';
part 'character_model.g.dart';

@freezed
abstract class CharacterModel with _$CharacterModel {
  const factory CharacterModel({
    required int id,
    required String name,
    required String status,
    required String species,
    required String type,
    required String gender,
    required LocationModel origin,
    required LocationModel location,
    required String image,
    required List<String> episode,
    required String url,
    required DateTime created,
  }) = _CharacterModel;

  factory CharacterModel.fromJson(Map<String, dynamic> json) =>
      _$CharacterModelFromJson(json);
}

@freezed
abstract class CharacterResponseModel with _$CharacterResponseModel {
  const factory CharacterResponseModel({
    required InfoModel info,
    required List<CharacterModel> results,
  }) = _CharacterResponseModel;

  factory CharacterResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CharacterResponseModelFromJson(json);
}
