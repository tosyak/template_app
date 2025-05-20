part of 'episodes_bloc.dart';

@freezed
class EpisodesEvent with _$EpisodesEvent  {
  const factory EpisodesEvent.started() = _Started;
  const factory EpisodesEvent.getEpisodesList({required int pageKey}) =
      _GetEpisodesList;
}
