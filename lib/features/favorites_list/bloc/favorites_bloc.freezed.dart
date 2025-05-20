// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favorites_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FavoritesEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is FavoritesEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'FavoritesEvent()';
  }
}

/// @nodoc
class $FavoritesEventCopyWith<$Res> {
  $FavoritesEventCopyWith(FavoritesEvent _, $Res Function(FavoritesEvent) __);
}

/// @nodoc

class _GetFavoritesList implements FavoritesEvent {
  const _GetFavoritesList();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _GetFavoritesList);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'FavoritesEvent.getFavoritesList()';
  }
}

/// @nodoc

class _RemoveFavorite implements FavoritesEvent {
  const _RemoveFavorite(this.characterId);

  final int characterId;

  /// Create a copy of FavoritesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RemoveFavoriteCopyWith<_RemoveFavorite> get copyWith =>
      __$RemoveFavoriteCopyWithImpl<_RemoveFavorite>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RemoveFavorite &&
            (identical(other.characterId, characterId) ||
                other.characterId == characterId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, characterId);

  @override
  String toString() {
    return 'FavoritesEvent.removeFavorite(characterId: $characterId)';
  }
}

/// @nodoc
abstract mixin class _$RemoveFavoriteCopyWith<$Res>
    implements $FavoritesEventCopyWith<$Res> {
  factory _$RemoveFavoriteCopyWith(
          _RemoveFavorite value, $Res Function(_RemoveFavorite) _then) =
      __$RemoveFavoriteCopyWithImpl;
  @useResult
  $Res call({int characterId});
}

/// @nodoc
class __$RemoveFavoriteCopyWithImpl<$Res>
    implements _$RemoveFavoriteCopyWith<$Res> {
  __$RemoveFavoriteCopyWithImpl(this._self, this._then);

  final _RemoveFavorite _self;
  final $Res Function(_RemoveFavorite) _then;

  /// Create a copy of FavoritesEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? characterId = null,
  }) {
    return _then(_RemoveFavorite(
      null == characterId
          ? _self.characterId
          : characterId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _AddFavorite implements FavoritesEvent {
  const _AddFavorite(this.characterId);

  final int characterId;

  /// Create a copy of FavoritesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AddFavoriteCopyWith<_AddFavorite> get copyWith =>
      __$AddFavoriteCopyWithImpl<_AddFavorite>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AddFavorite &&
            (identical(other.characterId, characterId) ||
                other.characterId == characterId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, characterId);

  @override
  String toString() {
    return 'FavoritesEvent.addFavorite(characterId: $characterId)';
  }
}

/// @nodoc
abstract mixin class _$AddFavoriteCopyWith<$Res>
    implements $FavoritesEventCopyWith<$Res> {
  factory _$AddFavoriteCopyWith(
          _AddFavorite value, $Res Function(_AddFavorite) _then) =
      __$AddFavoriteCopyWithImpl;
  @useResult
  $Res call({int characterId});
}

/// @nodoc
class __$AddFavoriteCopyWithImpl<$Res> implements _$AddFavoriteCopyWith<$Res> {
  __$AddFavoriteCopyWithImpl(this._self, this._then);

  final _AddFavorite _self;
  final $Res Function(_AddFavorite) _then;

  /// Create a copy of FavoritesEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? characterId = null,
  }) {
    return _then(_AddFavorite(
      null == characterId
          ? _self.characterId
          : characterId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _RefreshFavorites implements FavoritesEvent {
  const _RefreshFavorites();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _RefreshFavorites);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'FavoritesEvent.refreshFavorites()';
  }
}

/// @nodoc

class _RefreshState implements FavoritesEvent {
  const _RefreshState();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _RefreshState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'FavoritesEvent.refreshState()';
  }
}

/// @nodoc
mixin _$FavoritesState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is FavoritesState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'FavoritesState()';
  }
}

/// @nodoc
class $FavoritesStateCopyWith<$Res> {
  $FavoritesStateCopyWith(FavoritesState _, $Res Function(FavoritesState) __);
}

/// @nodoc

class _Initial implements FavoritesState {
  const _Initial();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _Initial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'FavoritesState.initial()';
  }
}

/// @nodoc

class FavoritesLoading implements FavoritesState {
  const FavoritesLoading();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is FavoritesLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'FavoritesState.loading()';
  }
}

/// @nodoc

class FavoritesError implements FavoritesState {
  const FavoritesError(this.message);

  final String message;

  /// Create a copy of FavoritesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FavoritesErrorCopyWith<FavoritesError> get copyWith =>
      _$FavoritesErrorCopyWithImpl<FavoritesError>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FavoritesError &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'FavoritesState.error(message: $message)';
  }
}

/// @nodoc
abstract mixin class $FavoritesErrorCopyWith<$Res>
    implements $FavoritesStateCopyWith<$Res> {
  factory $FavoritesErrorCopyWith(
          FavoritesError value, $Res Function(FavoritesError) _then) =
      _$FavoritesErrorCopyWithImpl;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$FavoritesErrorCopyWithImpl<$Res>
    implements $FavoritesErrorCopyWith<$Res> {
  _$FavoritesErrorCopyWithImpl(this._self, this._then);

  final FavoritesError _self;
  final $Res Function(FavoritesError) _then;

  /// Create a copy of FavoritesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
  }) {
    return _then(FavoritesError(
      null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class FavoriteListLoaded implements FavoritesState {
  const FavoriteListLoaded(
      {required final List<Character> characters,
      required final List<int> favoriteIds,
      this.isRemoving = false,
      this.isAdding = false})
      : _characters = characters,
        _favoriteIds = favoriteIds;

  final List<Character> _characters;
  List<Character> get characters {
    if (_characters is EqualUnmodifiableListView) return _characters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_characters);
  }

  final List<int> _favoriteIds;
  List<int> get favoriteIds {
    if (_favoriteIds is EqualUnmodifiableListView) return _favoriteIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_favoriteIds);
  }

  @JsonKey()
  final bool isRemoving;
  @JsonKey()
  final bool isAdding;

  /// Create a copy of FavoritesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FavoriteListLoadedCopyWith<FavoriteListLoaded> get copyWith =>
      _$FavoriteListLoadedCopyWithImpl<FavoriteListLoaded>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FavoriteListLoaded &&
            const DeepCollectionEquality()
                .equals(other._characters, _characters) &&
            const DeepCollectionEquality()
                .equals(other._favoriteIds, _favoriteIds) &&
            (identical(other.isRemoving, isRemoving) ||
                other.isRemoving == isRemoving) &&
            (identical(other.isAdding, isAdding) ||
                other.isAdding == isAdding));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_characters),
      const DeepCollectionEquality().hash(_favoriteIds),
      isRemoving,
      isAdding);

  @override
  String toString() {
    return 'FavoritesState.favoriteListLoaded(characters: $characters, favoriteIds: $favoriteIds, isRemoving: $isRemoving, isAdding: $isAdding)';
  }
}

/// @nodoc
abstract mixin class $FavoriteListLoadedCopyWith<$Res>
    implements $FavoritesStateCopyWith<$Res> {
  factory $FavoriteListLoadedCopyWith(
          FavoriteListLoaded value, $Res Function(FavoriteListLoaded) _then) =
      _$FavoriteListLoadedCopyWithImpl;
  @useResult
  $Res call(
      {List<Character> characters,
      List<int> favoriteIds,
      bool isRemoving,
      bool isAdding});
}

/// @nodoc
class _$FavoriteListLoadedCopyWithImpl<$Res>
    implements $FavoriteListLoadedCopyWith<$Res> {
  _$FavoriteListLoadedCopyWithImpl(this._self, this._then);

  final FavoriteListLoaded _self;
  final $Res Function(FavoriteListLoaded) _then;

  /// Create a copy of FavoritesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? characters = null,
    Object? favoriteIds = null,
    Object? isRemoving = null,
    Object? isAdding = null,
  }) {
    return _then(FavoriteListLoaded(
      characters: null == characters
          ? _self._characters
          : characters // ignore: cast_nullable_to_non_nullable
              as List<Character>,
      favoriteIds: null == favoriteIds
          ? _self._favoriteIds
          : favoriteIds // ignore: cast_nullable_to_non_nullable
              as List<int>,
      isRemoving: null == isRemoving
          ? _self.isRemoving
          : isRemoving // ignore: cast_nullable_to_non_nullable
              as bool,
      isAdding: null == isAdding
          ? _self.isAdding
          : isAdding // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
