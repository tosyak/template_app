part of 'favorites_bloc.dart';

@freezed
class FavoritesState with _$FavoritesState {
  const factory FavoritesState.initial() = _Initial;
  const factory FavoritesState.loading() = FavoritesLoading;
  const factory FavoritesState.error(String message) = FavoritesError;
  const factory FavoritesState.favoriteListLoaded({
    required List<Character> characters,
    required List<int> favoriteIds,
    @Default(false) bool isRemoving,
    @Default(false) bool isAdding,
  }) = FavoriteListLoaded;
}
