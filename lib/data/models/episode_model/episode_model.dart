import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ricknotmorty/data/models/info_model/info_model.dart';

part 'episode_model.freezed.dart';
part 'episode_model.g.dart';

@freezed
abstract class EpisodeModel with _$EpisodeModel {
  const factory EpisodeModel({
    required String id,
    required String name,
    @JsonKey(name: 'air_date') required String airDate,
    required String episode,
    required DateTime created,
  }) = _EpisodeModel;

  factory EpisodeModel.fromJson(Map<String, dynamic> json) =>
      _$EpisodeModelFromJson(json);
}

@freezed
abstract class EpisodeResponseModel with _$EpisodeResponseModel {
  const factory EpisodeResponseModel({
    required GraphQLInfoModel info,
    required List<EpisodeModel> results,
  }) = _EpisodeResponseModel;

  factory EpisodeResponseModel.fromJson(Map<String, dynamic> json) =>
      _$EpisodeResponseModelFromJson(json);
}
