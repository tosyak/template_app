part of 'favorites_bloc.dart';

@freezed
class FavoritesEvent with _$FavoritesEvent {
  const factory FavoritesEvent.getFavoritesList() = _GetFavoritesList;
  const factory FavoritesEvent.removeFavorite(int characterId) =
      _RemoveFavorite;
  const factory FavoritesEvent.addFavorite(int characterId) = _AddFavorite;
  const factory FavoritesEvent.refreshFavorites() = _RefreshFavorites;
  const factory FavoritesEvent.refreshState() = _RefreshState;
}
