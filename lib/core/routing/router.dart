import 'package:auto_route/auto_route.dart';
import 'package:ricknotmorty/core/routing/router.gr.dart';
import 'package:ricknotmorty/core/service_locator/service_locator.dart';
import 'package:ricknotmorty/features/character_details/ui/pages/character_details_screen.dart';
import 'package:ricknotmorty/features/characters_list/pages/characters_screen.dart';
import 'package:ricknotmorty/features/episodes_list/ui/pages/episodes_screen.dart';
import 'package:ricknotmorty/features/favorites_list/pages/favorites_screen.dart';
import 'package:ricknotmorty/features/main_page/main_page.dart';
import 'package:ricknotmorty/features/settings/pages/settings_screen.dart';
import 'package:ricknotmorty/features/splash/splash_screen.dart';
import 'package:ricknotmorty/features/widgets/network_error_dialog.dart';

/// Defines the root router configuration for the application.
///
/// This router manages the top-level navigation stack and routes
/// for the entire application using AutoRoute.

AppRouter get router => getIt<AppRouter>();

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
            page: Splash.page, path: SplashScreen.routeName, initial: true),
        AutoRoute(
          page: MainPageRoute.page,
          path: MainPage.routeName,
          children: [
            AutoRoute(
                page: CharactersRoute.page,
                path: CharactersScreen.routeName,
                maintainState: false),
            AutoRoute(page: EpisodesRoute.page, path: EpisodesScreen.routeName),
            AutoRoute(
                page: FavoritesRoute.page,
                path: FavoritesScreen.routeName,
                maintainState: false),
          ],
        ),
        AutoRoute(
          page: CharacterDetailsRoute.page,
          path: CharacterDetailsScreen.routeName,
        ),
        AutoRoute(
          page: SettingsRoute.page,
          path: SettingsScreen.routeName,
        ),
        AutoRoute(
            page: NetworkErrorRoute.page, path: NetworkErrorDialog.routeName),
      ];
}
