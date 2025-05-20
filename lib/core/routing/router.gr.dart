// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i9;
import 'package:flutter/cupertino.dart' as _i10;
import 'package:ricknotmorty/domain/entities/character_entity.dart' as _i11;
import 'package:ricknotmorty/features/character_details/character_details.dart'
    as _i1;
import 'package:ricknotmorty/features/characters_list/pages/characters_screen.dart'
    as _i2;
import 'package:ricknotmorty/features/episodes_list/ui/pages/episodes_screen.dart'
    as _i3;
import 'package:ricknotmorty/features/favorites_list/pages/favorites_screen.dart'
    as _i4;
import 'package:ricknotmorty/features/main_page/main_page.dart' as _i5;
import 'package:ricknotmorty/features/settings/pages/settings_screen.dart'
    as _i7;
import 'package:ricknotmorty/features/splash/splash_screen.dart' as _i8;
import 'package:ricknotmorty/features/widgets/network_error_dialog.dart' as _i6;

/// generated route for
/// [_i1.CharacterDetails]
class CharacterDetailsRoute
    extends _i9.PageRouteInfo<CharacterDetailsRouteArgs> {
  CharacterDetailsRoute({
    _i10.Key? key,
    required _i11.Character character,
    List<_i9.PageRouteInfo>? children,
  }) : super(
         CharacterDetailsRoute.name,
         args: CharacterDetailsRouteArgs(key: key, character: character),
         initialChildren: children,
       );

  static const String name = 'CharacterDetailsRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CharacterDetailsRouteArgs>();
      return _i1.CharacterDetails(key: args.key, character: args.character);
    },
  );
}

class CharacterDetailsRouteArgs {
  const CharacterDetailsRouteArgs({this.key, required this.character});

  final _i10.Key? key;

  final _i11.Character character;

  @override
  String toString() {
    return 'CharacterDetailsRouteArgs{key: $key, character: $character}';
  }
}

/// generated route for
/// [_i2.CharactersScreen]
class CharactersRoute extends _i9.PageRouteInfo<void> {
  const CharactersRoute({List<_i9.PageRouteInfo>? children})
    : super(CharactersRoute.name, initialChildren: children);

  static const String name = 'CharactersRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i2.CharactersScreen();
    },
  );
}

/// generated route for
/// [_i3.EpisodesScreen]
class EpisodesRoute extends _i9.PageRouteInfo<void> {
  const EpisodesRoute({List<_i9.PageRouteInfo>? children})
    : super(EpisodesRoute.name, initialChildren: children);

  static const String name = 'EpisodesRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i3.EpisodesScreen();
    },
  );
}

/// generated route for
/// [_i4.FavoritesScreen]
class FavoritesRoute extends _i9.PageRouteInfo<void> {
  const FavoritesRoute({List<_i9.PageRouteInfo>? children})
    : super(FavoritesRoute.name, initialChildren: children);

  static const String name = 'FavoritesRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i4.FavoritesScreen();
    },
  );
}

/// generated route for
/// [_i5.MainPage]
class MainPageRoute extends _i9.PageRouteInfo<void> {
  const MainPageRoute({List<_i9.PageRouteInfo>? children})
    : super(MainPageRoute.name, initialChildren: children);

  static const String name = 'MainPageRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i5.MainPage();
    },
  );
}

/// generated route for
/// [_i6.NetworkErrorDialog]
class NetworkErrorRoute extends _i9.PageRouteInfo<void> {
  const NetworkErrorRoute({List<_i9.PageRouteInfo>? children})
    : super(NetworkErrorRoute.name, initialChildren: children);

  static const String name = 'NetworkErrorRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i6.NetworkErrorDialog();
    },
  );
}

/// generated route for
/// [_i7.SettingsScreen]
class SettingsRoute extends _i9.PageRouteInfo<void> {
  const SettingsRoute({List<_i9.PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i7.SettingsScreen();
    },
  );
}

/// generated route for
/// [_i8.SplashScreen]
class Splash extends _i9.PageRouteInfo<void> {
  const Splash({List<_i9.PageRouteInfo>? children})
    : super(Splash.name, initialChildren: children);

  static const String name = 'Splash';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i8.SplashScreen();
    },
  );
}
