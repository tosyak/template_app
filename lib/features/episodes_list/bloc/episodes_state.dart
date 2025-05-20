part of 'episodes_bloc.dart';

@freezed
class EpisodesState with _$EpisodesState {
  const factory EpisodesState.initial() = _Initial;
  const factory EpisodesState.loading() = Loading;
  const factory EpisodesState.success(EpisodeResponse episodes) = Success;
  const factory EpisodesState.error(String message) = Error;
}
