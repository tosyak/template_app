part of 'characters_bloc.dart';

@freezed
class CharactersEvent with _$CharactersEvent {
  const factory CharactersEvent.started() = _Started;

  const factory CharactersEvent.getCharactersList({
    required int pageKey,
    String? name,
    String? status,
    String? species,
    String? type,
    String? gender,
  }) = _GetCharactersList;

  const factory CharactersEvent.getFavoriteIds() = _GetFavoriteIds;
  const factory CharactersEvent.addFavorite(int id) = _AddFavorite;
  const factory CharactersEvent.removeFavorite(int id) = _RemoveFavorite;
  const factory CharactersEvent.reset() = _ResetState;
}
