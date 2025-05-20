// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'episodes_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EpisodesEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is EpisodesEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'EpisodesEvent()';
  }
}

/// @nodoc
class $EpisodesEventCopyWith<$Res> {
  $EpisodesEventCopyWith(EpisodesEvent _, $Res Function(EpisodesEvent) __);
}

/// @nodoc

class _Started implements EpisodesEvent {
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
    return 'EpisodesEvent.started()';
  }
}

/// @nodoc

class _GetEpisodesList implements EpisodesEvent {
  const _GetEpisodesList({required this.pageKey});

  final int pageKey;

  /// Create a copy of EpisodesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GetEpisodesListCopyWith<_GetEpisodesList> get copyWith =>
      __$GetEpisodesListCopyWithImpl<_GetEpisodesList>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GetEpisodesList &&
            (identical(other.pageKey, pageKey) || other.pageKey == pageKey));
  }

  @override
  int get hashCode => Object.hash(runtimeType, pageKey);

  @override
  String toString() {
    return 'EpisodesEvent.getEpisodesList(pageKey: $pageKey)';
  }
}

/// @nodoc
abstract mixin class _$GetEpisodesListCopyWith<$Res>
    implements $EpisodesEventCopyWith<$Res> {
  factory _$GetEpisodesListCopyWith(
          _GetEpisodesList value, $Res Function(_GetEpisodesList) _then) =
      __$GetEpisodesListCopyWithImpl;
  @useResult
  $Res call({int pageKey});
}

/// @nodoc
class __$GetEpisodesListCopyWithImpl<$Res>
    implements _$GetEpisodesListCopyWith<$Res> {
  __$GetEpisodesListCopyWithImpl(this._self, this._then);

  final _GetEpisodesList _self;
  final $Res Function(_GetEpisodesList) _then;

  /// Create a copy of EpisodesEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? pageKey = null,
  }) {
    return _then(_GetEpisodesList(
      pageKey: null == pageKey
          ? _self.pageKey
          : pageKey // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$EpisodesState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is EpisodesState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'EpisodesState()';
  }
}

/// @nodoc
class $EpisodesStateCopyWith<$Res> {
  $EpisodesStateCopyWith(EpisodesState _, $Res Function(EpisodesState) __);
}

/// @nodoc

class _Initial implements EpisodesState {
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
    return 'EpisodesState.initial()';
  }
}

/// @nodoc

class Loading implements EpisodesState {
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
    return 'EpisodesState.loading()';
  }
}

/// @nodoc

class Success implements EpisodesState {
  const Success(this.episodes);

  final EpisodeResponse episodes;

  /// Create a copy of EpisodesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SuccessCopyWith<Success> get copyWith =>
      _$SuccessCopyWithImpl<Success>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Success &&
            (identical(other.episodes, episodes) ||
                other.episodes == episodes));
  }

  @override
  int get hashCode => Object.hash(runtimeType, episodes);

  @override
  String toString() {
    return 'EpisodesState.success(episodes: $episodes)';
  }
}

/// @nodoc
abstract mixin class $SuccessCopyWith<$Res>
    implements $EpisodesStateCopyWith<$Res> {
  factory $SuccessCopyWith(Success value, $Res Function(Success) _then) =
      _$SuccessCopyWithImpl;
  @useResult
  $Res call({EpisodeResponse episodes});
}

/// @nodoc
class _$SuccessCopyWithImpl<$Res> implements $SuccessCopyWith<$Res> {
  _$SuccessCopyWithImpl(this._self, this._then);

  final Success _self;
  final $Res Function(Success) _then;

  /// Create a copy of EpisodesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? episodes = null,
  }) {
    return _then(Success(
      null == episodes
          ? _self.episodes
          : episodes // ignore: cast_nullable_to_non_nullable
              as EpisodeResponse,
    ));
  }
}

/// @nodoc

class Error implements EpisodesState {
  const Error(this.message);

  final String message;

  /// Create a copy of EpisodesState
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
    return 'EpisodesState.error(message: $message)';
  }
}

/// @nodoc
abstract mixin class $ErrorCopyWith<$Res>
    implements $EpisodesStateCopyWith<$Res> {
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

  /// Create a copy of EpisodesState
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
