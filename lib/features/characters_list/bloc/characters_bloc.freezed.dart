// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'characters_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CharactersEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is CharactersEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'CharactersEvent()';
  }
}

/// @nodoc
class $CharactersEventCopyWith<$Res> {
  $CharactersEventCopyWith(
      CharactersEvent _, $Res Function(CharactersEvent) __);
}

/// @nodoc

class _Started implements CharactersEvent {
  const _Started();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _Started);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'CharactersEvent.started()';
  }
}

/// @nodoc

class _GetCharactersList implements CharactersEvent {
  const _GetCharactersList(
      {required this.pageKey,
      this.name,
      this.status,
      this.species,
      this.type,
      this.gender});

  final int pageKey;
  final String? name;
  final String? status;
  final String? species;
  final String? type;
  final String? gender;

  /// Create a copy of CharactersEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GetCharactersListCopyWith<_GetCharactersList> get copyWith =>
      __$GetCharactersListCopyWithImpl<_GetCharactersList>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GetCharactersList &&
            (identical(other.pageKey, pageKey) || other.pageKey == pageKey) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.species, species) || other.species == species) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.gender, gender) || other.gender == gender));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, pageKey, name, status, species, type, gender);

  @override
  String toString() {
    return 'CharactersEvent.getCharactersList(pageKey: $pageKey, name: $name, status: $status, species: $species, type: $type, gender: $gender)';
  }
}

/// @nodoc
abstract mixin class _$GetCharactersListCopyWith<$Res>
    implements $CharactersEventCopyWith<$Res> {
  factory _$GetCharactersListCopyWith(
          _GetCharactersList value, $Res Function(_GetCharactersList) _then) =
      __$GetCharactersListCopyWithImpl;
  @useResult
  $Res call(
      {int pageKey,
      String? name,
      String? status,
      String? species,
      String? type,
      String? gender});
}

/// @nodoc
class __$GetCharactersListCopyWithImpl<$Res>
    implements _$GetCharactersListCopyWith<$Res> {
  __$GetCharactersListCopyWithImpl(this._self, this._then);

  final _GetCharactersList _self;
  final $Res Function(_GetCharactersList) _then;

  /// Create a copy of CharactersEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? pageKey = null,
    Object? name = freezed,
    Object? status = freezed,
    Object? species = freezed,
    Object? type = freezed,
    Object? gender = freezed,
  }) {
    return _then(_GetCharactersList(
      pageKey: null == pageKey
          ? _self.pageKey
          : pageKey // ignore: cast_nullable_to_non_nullable
              as int,
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      species: freezed == species
          ? _self.species
          : species // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _self.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _GetFavoriteIds implements CharactersEvent {
  const _GetFavoriteIds();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _GetFavoriteIds);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'CharactersEvent.getFavoriteIds()';
  }
}

/// @nodoc

class _AddFavorite implements CharactersEvent {
  const _AddFavorite(this.id);

  final int id;

  /// Create a copy of CharactersEvent
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
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);

  @override
  String toString() {
    return 'CharactersEvent.addFavorite(id: $id)';
  }
}

/// @nodoc
abstract mixin class _$AddFavoriteCopyWith<$Res>
    implements $CharactersEventCopyWith<$Res> {
  factory _$AddFavoriteCopyWith(
          _AddFavorite value, $Res Function(_AddFavorite) _then) =
      __$AddFavoriteCopyWithImpl;
  @useResult
  $Res call({int id});
}

/// @nodoc
class __$AddFavoriteCopyWithImpl<$Res> implements _$AddFavoriteCopyWith<$Res> {
  __$AddFavoriteCopyWithImpl(this._self, this._then);

  final _AddFavorite _self;
  final $Res Function(_AddFavorite) _then;

  /// Create a copy of CharactersEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
  }) {
    return _then(_AddFavorite(
      null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _RemoveFavorite implements CharactersEvent {
  const _RemoveFavorite(this.id);

  final int id;

  /// Create a copy of CharactersEvent
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
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);

  @override
  String toString() {
    return 'CharactersEvent.removeFavorite(id: $id)';
  }
}

/// @nodoc
abstract mixin class _$RemoveFavoriteCopyWith<$Res>
    implements $CharactersEventCopyWith<$Res> {
  factory _$RemoveFavoriteCopyWith(
          _RemoveFavorite value, $Res Function(_RemoveFavorite) _then) =
      __$RemoveFavoriteCopyWithImpl;
  @useResult
  $Res call({int id});
}

/// @nodoc
class __$RemoveFavoriteCopyWithImpl<$Res>
    implements _$RemoveFavoriteCopyWith<$Res> {
  __$RemoveFavoriteCopyWithImpl(this._self, this._then);

  final _RemoveFavorite _self;
  final $Res Function(_RemoveFavorite) _then;

  /// Create a copy of CharactersEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
  }) {
    return _then(_RemoveFavorite(
      null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _ResetState implements CharactersEvent {
  const _ResetState();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _ResetState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'CharactersEvent.reset()';
  }
}

/// @nodoc
mixin _$CharactersState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is CharactersState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'CharactersState()';
  }
}

/// @nodoc
class $CharactersStateCopyWith<$Res> {
  $CharactersStateCopyWith(
      CharactersState _, $Res Function(CharactersState) __);
}

/// @nodoc

class _Initial implements CharactersState {
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
    return 'CharactersState.initial()';
  }
}

/// @nodoc

class Loading implements CharactersState {
  const Loading();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is Loading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'CharactersState.loading()';
  }
}

/// @nodoc

class CharacterResponseLoaded implements CharactersState {
  const CharacterResponseLoaded(
      {required this.characters, required final List<int> favoriteIds})
      : _favoriteIds = favoriteIds;

  final CharacterResponse characters;
  final List<int> _favoriteIds;
  List<int> get favoriteIds {
    if (_favoriteIds is EqualUnmodifiableListView) return _favoriteIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_favoriteIds);
  }

  /// Create a copy of CharactersState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CharacterResponseLoadedCopyWith<CharacterResponseLoaded> get copyWith =>
      _$CharacterResponseLoadedCopyWithImpl<CharacterResponseLoaded>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CharacterResponseLoaded &&
            (identical(other.characters, characters) ||
                other.characters == characters) &&
            const DeepCollectionEquality()
                .equals(other._favoriteIds, _favoriteIds));
  }

  @override
  int get hashCode => Object.hash(runtimeType, characters,
      const DeepCollectionEquality().hash(_favoriteIds));

  @override
  String toString() {
    return 'CharactersState.characterResponse(characters: $characters, favoriteIds: $favoriteIds)';
  }
}

/// @nodoc
abstract mixin class $CharacterResponseLoadedCopyWith<$Res>
    implements $CharactersStateCopyWith<$Res> {
  factory $CharacterResponseLoadedCopyWith(CharacterResponseLoaded value,
          $Res Function(CharacterResponseLoaded) _then) =
      _$CharacterResponseLoadedCopyWithImpl;
  @useResult
  $Res call({CharacterResponse characters, List<int> favoriteIds});
}

/// @nodoc
class _$CharacterResponseLoadedCopyWithImpl<$Res>
    implements $CharacterResponseLoadedCopyWith<$Res> {
  _$CharacterResponseLoadedCopyWithImpl(this._self, this._then);

  final CharacterResponseLoaded _self;
  final $Res Function(CharacterResponseLoaded) _then;

  /// Create a copy of CharactersState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? characters = null,
    Object? favoriteIds = null,
  }) {
    return _then(CharacterResponseLoaded(
      characters: null == characters
          ? _self.characters
          : characters // ignore: cast_nullable_to_non_nullable
              as CharacterResponse,
      favoriteIds: null == favoriteIds
          ? _self._favoriteIds
          : favoriteIds // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// @nodoc

class FavoriteIdsLoaded implements CharactersState {
  const FavoriteIdsLoaded();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is FavoriteIdsLoaded);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'CharactersState.getFavoriteIds()';
  }
}

/// @nodoc

class Error implements CharactersState {
  const Error(this.message);

  final String message;

  /// Create a copy of CharactersState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ErrorCopyWith<Error> get copyWith =>
      _$ErrorCopyWithImpl<Error>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Error &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'CharactersState.error(message: $message)';
  }
}

/// @nodoc
abstract mixin class $ErrorCopyWith<$Res>
    implements $CharactersStateCopyWith<$Res> {
  factory $ErrorCopyWith(Error value, $Res Function(Error) _then) =
      _$ErrorCopyWithImpl;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$ErrorCopyWithImpl<$Res> implements $ErrorCopyWith<$Res> {
  _$ErrorCopyWithImpl(this._self, this._then);

  final Error _self;
  final $Res Function(Error) _then;

  /// Create a copy of CharactersState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
  }) {
    return _then(Error(
      null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
