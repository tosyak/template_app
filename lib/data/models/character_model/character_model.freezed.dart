// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'character_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CharacterModel {
  int get id;
  String get name;
  String get status;
  String get species;
  String get type;
  String get gender;
  LocationModel get origin;
  LocationModel get location;
  String get image;
  List<String> get episode;
  String get url;
  DateTime get created;

  /// Create a copy of CharacterModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CharacterModelCopyWith<CharacterModel> get copyWith =>
      _$CharacterModelCopyWithImpl<CharacterModel>(
          this as CharacterModel, _$identity);

  /// Serializes this CharacterModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CharacterModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.species, species) || other.species == species) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.origin, origin) || other.origin == origin) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.image, image) || other.image == image) &&
            const DeepCollectionEquality().equals(other.episode, episode) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.created, created) || other.created == created));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      status,
      species,
      type,
      gender,
      origin,
      location,
      image,
      const DeepCollectionEquality().hash(episode),
      url,
      created);

  @override
  String toString() {
    return 'CharacterModel(id: $id, name: $name, status: $status, species: $species, type: $type, gender: $gender, origin: $origin, location: $location, image: $image, episode: $episode, url: $url, created: $created)';
  }
}

/// @nodoc
abstract mixin class $CharacterModelCopyWith<$Res> {
  factory $CharacterModelCopyWith(
          CharacterModel value, $Res Function(CharacterModel) _then) =
      _$CharacterModelCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      String name,
      String status,
      String species,
      String type,
      String gender,
      LocationModel origin,
      LocationModel location,
      String image,
      List<String> episode,
      String url,
      DateTime created});

  $LocationModelCopyWith<$Res> get origin;
  $LocationModelCopyWith<$Res> get location;
}

/// @nodoc
class _$CharacterModelCopyWithImpl<$Res>
    implements $CharacterModelCopyWith<$Res> {
  _$CharacterModelCopyWithImpl(this._self, this._then);

  final CharacterModel _self;
  final $Res Function(CharacterModel) _then;

  /// Create a copy of CharacterModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? status = null,
    Object? species = null,
    Object? type = null,
    Object? gender = null,
    Object? origin = null,
    Object? location = null,
    Object? image = null,
    Object? episode = null,
    Object? url = null,
    Object? created = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      species: null == species
          ? _self.species
          : species // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      gender: null == gender
          ? _self.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      origin: null == origin
          ? _self.origin
          : origin // ignore: cast_nullable_to_non_nullable
              as LocationModel,
      location: null == location
          ? _self.location
          : location // ignore: cast_nullable_to_non_nullable
              as LocationModel,
      image: null == image
          ? _self.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      episode: null == episode
          ? _self.episode
          : episode // ignore: cast_nullable_to_non_nullable
              as List<String>,
      url: null == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      created: null == created
          ? _self.created
          : created // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }

  /// Create a copy of CharacterModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LocationModelCopyWith<$Res> get origin {
    return $LocationModelCopyWith<$Res>(_self.origin, (value) {
      return _then(_self.copyWith(origin: value));
    });
  }

  /// Create a copy of CharacterModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LocationModelCopyWith<$Res> get location {
    return $LocationModelCopyWith<$Res>(_self.location, (value) {
      return _then(_self.copyWith(location: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _CharacterModel implements CharacterModel {
  const _CharacterModel(
      {required this.id,
      required this.name,
      required this.status,
      required this.species,
      required this.type,
      required this.gender,
      required this.origin,
      required this.location,
      required this.image,
      required final List<String> episode,
      required this.url,
      required this.created})
      : _episode = episode;
  factory _CharacterModel.fromJson(Map<String, dynamic> json) =>
      _$CharacterModelFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String status;
  @override
  final String species;
  @override
  final String type;
  @override
  final String gender;
  @override
  final LocationModel origin;
  @override
  final LocationModel location;
  @override
  final String image;
  final List<String> _episode;
  @override
  List<String> get episode {
    if (_episode is EqualUnmodifiableListView) return _episode;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_episode);
  }

  @override
  final String url;
  @override
  final DateTime created;

  /// Create a copy of CharacterModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CharacterModelCopyWith<_CharacterModel> get copyWith =>
      __$CharacterModelCopyWithImpl<_CharacterModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CharacterModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CharacterModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.species, species) || other.species == species) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.origin, origin) || other.origin == origin) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.image, image) || other.image == image) &&
            const DeepCollectionEquality().equals(other._episode, _episode) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.created, created) || other.created == created));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      status,
      species,
      type,
      gender,
      origin,
      location,
      image,
      const DeepCollectionEquality().hash(_episode),
      url,
      created);

  @override
  String toString() {
    return 'CharacterModel(id: $id, name: $name, status: $status, species: $species, type: $type, gender: $gender, origin: $origin, location: $location, image: $image, episode: $episode, url: $url, created: $created)';
  }
}

/// @nodoc
abstract mixin class _$CharacterModelCopyWith<$Res>
    implements $CharacterModelCopyWith<$Res> {
  factory _$CharacterModelCopyWith(
          _CharacterModel value, $Res Function(_CharacterModel) _then) =
      __$CharacterModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String status,
      String species,
      String type,
      String gender,
      LocationModel origin,
      LocationModel location,
      String image,
      List<String> episode,
      String url,
      DateTime created});

  @override
  $LocationModelCopyWith<$Res> get origin;
  @override
  $LocationModelCopyWith<$Res> get location;
}

/// @nodoc
class __$CharacterModelCopyWithImpl<$Res>
    implements _$CharacterModelCopyWith<$Res> {
  __$CharacterModelCopyWithImpl(this._self, this._then);

  final _CharacterModel _self;
  final $Res Function(_CharacterModel) _then;

  /// Create a copy of CharacterModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? status = null,
    Object? species = null,
    Object? type = null,
    Object? gender = null,
    Object? origin = null,
    Object? location = null,
    Object? image = null,
    Object? episode = null,
    Object? url = null,
    Object? created = null,
  }) {
    return _then(_CharacterModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      species: null == species
          ? _self.species
          : species // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      gender: null == gender
          ? _self.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      origin: null == origin
          ? _self.origin
          : origin // ignore: cast_nullable_to_non_nullable
              as LocationModel,
      location: null == location
          ? _self.location
          : location // ignore: cast_nullable_to_non_nullable
              as LocationModel,
      image: null == image
          ? _self.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      episode: null == episode
          ? _self._episode
          : episode // ignore: cast_nullable_to_non_nullable
              as List<String>,
      url: null == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      created: null == created
          ? _self.created
          : created // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }

  /// Create a copy of CharacterModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LocationModelCopyWith<$Res> get origin {
    return $LocationModelCopyWith<$Res>(_self.origin, (value) {
      return _then(_self.copyWith(origin: value));
    });
  }

  /// Create a copy of CharacterModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LocationModelCopyWith<$Res> get location {
    return $LocationModelCopyWith<$Res>(_self.location, (value) {
      return _then(_self.copyWith(location: value));
    });
  }
}

/// @nodoc
mixin _$CharacterResponseModel {
  InfoModel get info;
  List<CharacterModel> get results;

  /// Create a copy of CharacterResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CharacterResponseModelCopyWith<CharacterResponseModel> get copyWith =>
      _$CharacterResponseModelCopyWithImpl<CharacterResponseModel>(
          this as CharacterResponseModel, _$identity);

  /// Serializes this CharacterResponseModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CharacterResponseModel &&
            (identical(other.info, info) || other.info == info) &&
            const DeepCollectionEquality().equals(other.results, results));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, info, const DeepCollectionEquality().hash(results));

  @override
  String toString() {
    return 'CharacterResponseModel(info: $info, results: $results)';
  }
}

/// @nodoc
abstract mixin class $CharacterResponseModelCopyWith<$Res> {
  factory $CharacterResponseModelCopyWith(CharacterResponseModel value,
          $Res Function(CharacterResponseModel) _then) =
      _$CharacterResponseModelCopyWithImpl;
  @useResult
  $Res call({InfoModel info, List<CharacterModel> results});

  $InfoModelCopyWith<$Res> get info;
}

/// @nodoc
class _$CharacterResponseModelCopyWithImpl<$Res>
    implements $CharacterResponseModelCopyWith<$Res> {
  _$CharacterResponseModelCopyWithImpl(this._self, this._then);

  final CharacterResponseModel _self;
  final $Res Function(CharacterResponseModel) _then;

  /// Create a copy of CharacterResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? info = null,
    Object? results = null,
  }) {
    return _then(_self.copyWith(
      info: null == info
          ? _self.info
          : info // ignore: cast_nullable_to_non_nullable
              as InfoModel,
      results: null == results
          ? _self.results
          : results // ignore: cast_nullable_to_non_nullable
              as List<CharacterModel>,
    ));
  }

  /// Create a copy of CharacterResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $InfoModelCopyWith<$Res> get info {
    return $InfoModelCopyWith<$Res>(_self.info, (value) {
      return _then(_self.copyWith(info: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _CharacterResponseModel implements CharacterResponseModel {
  const _CharacterResponseModel(
      {required this.info, required final List<CharacterModel> results})
      : _results = results;
  factory _CharacterResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CharacterResponseModelFromJson(json);

  @override
  final InfoModel info;
  final List<CharacterModel> _results;
  @override
  List<CharacterModel> get results {
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_results);
  }

  /// Create a copy of CharacterResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CharacterResponseModelCopyWith<_CharacterResponseModel> get copyWith =>
      __$CharacterResponseModelCopyWithImpl<_CharacterResponseModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CharacterResponseModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CharacterResponseModel &&
            (identical(other.info, info) || other.info == info) &&
            const DeepCollectionEquality().equals(other._results, _results));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, info, const DeepCollectionEquality().hash(_results));

  @override
  String toString() {
    return 'CharacterResponseModel(info: $info, results: $results)';
  }
}

/// @nodoc
abstract mixin class _$CharacterResponseModelCopyWith<$Res>
    implements $CharacterResponseModelCopyWith<$Res> {
  factory _$CharacterResponseModelCopyWith(_CharacterResponseModel value,
          $Res Function(_CharacterResponseModel) _then) =
      __$CharacterResponseModelCopyWithImpl;
  @override
  @useResult
  $Res call({InfoModel info, List<CharacterModel> results});

  @override
  $InfoModelCopyWith<$Res> get info;
}

/// @nodoc
class __$CharacterResponseModelCopyWithImpl<$Res>
    implements _$CharacterResponseModelCopyWith<$Res> {
  __$CharacterResponseModelCopyWithImpl(this._self, this._then);

  final _CharacterResponseModel _self;
  final $Res Function(_CharacterResponseModel) _then;

  /// Create a copy of CharacterResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? info = null,
    Object? results = null,
  }) {
    return _then(_CharacterResponseModel(
      info: null == info
          ? _self.info
          : info // ignore: cast_nullable_to_non_nullable
              as InfoModel,
      results: null == results
          ? _self._results
          : results // ignore: cast_nullable_to_non_nullable
              as List<CharacterModel>,
    ));
  }

  /// Create a copy of CharacterResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $InfoModelCopyWith<$Res> get info {
    return $InfoModelCopyWith<$Res>(_self.info, (value) {
      return _then(_self.copyWith(info: value));
    });
  }
}

// dart format on
