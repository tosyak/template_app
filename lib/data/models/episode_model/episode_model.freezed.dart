// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'episode_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EpisodeModel {
  String get id;
  String get name;
  @JsonKey(name: 'air_date')
  String get airDate;
  String get episode;
  DateTime get created;

  /// Create a copy of EpisodeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $EpisodeModelCopyWith<EpisodeModel> get copyWith =>
      _$EpisodeModelCopyWithImpl<EpisodeModel>(
          this as EpisodeModel, _$identity);

  /// Serializes this EpisodeModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EpisodeModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.airDate, airDate) || other.airDate == airDate) &&
            (identical(other.episode, episode) || other.episode == episode) &&
            (identical(other.created, created) || other.created == created));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, airDate, episode, created);

  @override
  String toString() {
    return 'EpisodeModel(id: $id, name: $name, airDate: $airDate, episode: $episode, created: $created)';
  }
}

/// @nodoc
abstract mixin class $EpisodeModelCopyWith<$Res> {
  factory $EpisodeModelCopyWith(
          EpisodeModel value, $Res Function(EpisodeModel) _then) =
      _$EpisodeModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String name,
      @JsonKey(name: 'air_date') String airDate,
      String episode,
      DateTime created});
}

/// @nodoc
class _$EpisodeModelCopyWithImpl<$Res> implements $EpisodeModelCopyWith<$Res> {
  _$EpisodeModelCopyWithImpl(this._self, this._then);

  final EpisodeModel _self;
  final $Res Function(EpisodeModel) _then;

  /// Create a copy of EpisodeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? airDate = null,
    Object? episode = null,
    Object? created = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      airDate: null == airDate
          ? _self.airDate
          : airDate // ignore: cast_nullable_to_non_nullable
              as String,
      episode: null == episode
          ? _self.episode
          : episode // ignore: cast_nullable_to_non_nullable
              as String,
      created: null == created
          ? _self.created
          : created // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _EpisodeModel implements EpisodeModel {
  const _EpisodeModel(
      {required this.id,
      required this.name,
      @JsonKey(name: 'air_date') required this.airDate,
      required this.episode,
      required this.created});
  factory _EpisodeModel.fromJson(Map<String, dynamic> json) =>
      _$EpisodeModelFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  @JsonKey(name: 'air_date')
  final String airDate;
  @override
  final String episode;
  @override
  final DateTime created;

  /// Create a copy of EpisodeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$EpisodeModelCopyWith<_EpisodeModel> get copyWith =>
      __$EpisodeModelCopyWithImpl<_EpisodeModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$EpisodeModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _EpisodeModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.airDate, airDate) || other.airDate == airDate) &&
            (identical(other.episode, episode) || other.episode == episode) &&
            (identical(other.created, created) || other.created == created));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, airDate, episode, created);

  @override
  String toString() {
    return 'EpisodeModel(id: $id, name: $name, airDate: $airDate, episode: $episode, created: $created)';
  }
}

/// @nodoc
abstract mixin class _$EpisodeModelCopyWith<$Res>
    implements $EpisodeModelCopyWith<$Res> {
  factory _$EpisodeModelCopyWith(
          _EpisodeModel value, $Res Function(_EpisodeModel) _then) =
      __$EpisodeModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      @JsonKey(name: 'air_date') String airDate,
      String episode,
      DateTime created});
}

/// @nodoc
class __$EpisodeModelCopyWithImpl<$Res>
    implements _$EpisodeModelCopyWith<$Res> {
  __$EpisodeModelCopyWithImpl(this._self, this._then);

  final _EpisodeModel _self;
  final $Res Function(_EpisodeModel) _then;

  /// Create a copy of EpisodeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? airDate = null,
    Object? episode = null,
    Object? created = null,
  }) {
    return _then(_EpisodeModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      airDate: null == airDate
          ? _self.airDate
          : airDate // ignore: cast_nullable_to_non_nullable
              as String,
      episode: null == episode
          ? _self.episode
          : episode // ignore: cast_nullable_to_non_nullable
              as String,
      created: null == created
          ? _self.created
          : created // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
mixin _$EpisodeResponseModel {
  GraphQLInfoModel get info;
  List<EpisodeModel> get results;

  /// Create a copy of EpisodeResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $EpisodeResponseModelCopyWith<EpisodeResponseModel> get copyWith =>
      _$EpisodeResponseModelCopyWithImpl<EpisodeResponseModel>(
          this as EpisodeResponseModel, _$identity);

  /// Serializes this EpisodeResponseModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EpisodeResponseModel &&
            (identical(other.info, info) || other.info == info) &&
            const DeepCollectionEquality().equals(other.results, results));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, info, const DeepCollectionEquality().hash(results));

  @override
  String toString() {
    return 'EpisodeResponseModel(info: $info, results: $results)';
  }
}

/// @nodoc
abstract mixin class $EpisodeResponseModelCopyWith<$Res> {
  factory $EpisodeResponseModelCopyWith(EpisodeResponseModel value,
          $Res Function(EpisodeResponseModel) _then) =
      _$EpisodeResponseModelCopyWithImpl;
  @useResult
  $Res call({GraphQLInfoModel info, List<EpisodeModel> results});

  $GraphQLInfoModelCopyWith<$Res> get info;
}

/// @nodoc
class _$EpisodeResponseModelCopyWithImpl<$Res>
    implements $EpisodeResponseModelCopyWith<$Res> {
  _$EpisodeResponseModelCopyWithImpl(this._self, this._then);

  final EpisodeResponseModel _self;
  final $Res Function(EpisodeResponseModel) _then;

  /// Create a copy of EpisodeResponseModel
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
              as GraphQLInfoModel,
      results: null == results
          ? _self.results
          : results // ignore: cast_nullable_to_non_nullable
              as List<EpisodeModel>,
    ));
  }

  /// Create a copy of EpisodeResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GraphQLInfoModelCopyWith<$Res> get info {
    return $GraphQLInfoModelCopyWith<$Res>(_self.info, (value) {
      return _then(_self.copyWith(info: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _EpisodeResponseModel implements EpisodeResponseModel {
  const _EpisodeResponseModel(
      {required this.info, required final List<EpisodeModel> results})
      : _results = results;
  factory _EpisodeResponseModel.fromJson(Map<String, dynamic> json) =>
      _$EpisodeResponseModelFromJson(json);

  @override
  final GraphQLInfoModel info;
  final List<EpisodeModel> _results;
  @override
  List<EpisodeModel> get results {
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_results);
  }

  /// Create a copy of EpisodeResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$EpisodeResponseModelCopyWith<_EpisodeResponseModel> get copyWith =>
      __$EpisodeResponseModelCopyWithImpl<_EpisodeResponseModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$EpisodeResponseModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _EpisodeResponseModel &&
            (identical(other.info, info) || other.info == info) &&
            const DeepCollectionEquality().equals(other._results, _results));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, info, const DeepCollectionEquality().hash(_results));

  @override
  String toString() {
    return 'EpisodeResponseModel(info: $info, results: $results)';
  }
}

/// @nodoc
abstract mixin class _$EpisodeResponseModelCopyWith<$Res>
    implements $EpisodeResponseModelCopyWith<$Res> {
  factory _$EpisodeResponseModelCopyWith(_EpisodeResponseModel value,
          $Res Function(_EpisodeResponseModel) _then) =
      __$EpisodeResponseModelCopyWithImpl;
  @override
  @useResult
  $Res call({GraphQLInfoModel info, List<EpisodeModel> results});

  @override
  $GraphQLInfoModelCopyWith<$Res> get info;
}

/// @nodoc
class __$EpisodeResponseModelCopyWithImpl<$Res>
    implements _$EpisodeResponseModelCopyWith<$Res> {
  __$EpisodeResponseModelCopyWithImpl(this._self, this._then);

  final _EpisodeResponseModel _self;
  final $Res Function(_EpisodeResponseModel) _then;

  /// Create a copy of EpisodeResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? info = null,
    Object? results = null,
  }) {
    return _then(_EpisodeResponseModel(
      info: null == info
          ? _self.info
          : info // ignore: cast_nullable_to_non_nullable
              as GraphQLInfoModel,
      results: null == results
          ? _self._results
          : results // ignore: cast_nullable_to_non_nullable
              as List<EpisodeModel>,
    ));
  }

  /// Create a copy of EpisodeResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GraphQLInfoModelCopyWith<$Res> get info {
    return $GraphQLInfoModelCopyWith<$Res>(_self.info, (value) {
      return _then(_self.copyWith(info: value));
    });
  }
}

// dart format on
