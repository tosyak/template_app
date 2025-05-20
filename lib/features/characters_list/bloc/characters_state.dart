part of 'characters_bloc.dart';

@freezed
class CharactersState with _$CharactersState {
  const factory CharactersState.initial() = _Initial;
  const factory CharactersState.loading() = Loading;
  const factory CharactersState.characterResponse(
      {required CharacterResponse characters,
      required List<int> favoriteIds}) = CharacterResponseLoaded;

  const factory CharactersState.getFavoriteIds() = FavoriteIdsLoaded;
  const factory CharactersState.error(String message) = Error;
}
