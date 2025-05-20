import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricknotmorty/core/service_locator/service_locator.dart';
import 'package:ricknotmorty/features/characters_list/bloc/characters_bloc.dart';
import 'package:ricknotmorty/features/favorites_list/bloc/favorites_bloc.dart';
import 'package:ricknotmorty/features/favorites_list/views/favorites_list_view.dart';

@RoutePage(name: "FavoritesRoute")
class FavoritesScreen extends StatelessWidget {
  static const routeName = 'favorites-route';
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              getIt<FavoritesBloc>()..add(FavoritesEvent.getFavoritesList()),
        ),
        BlocProvider(
          create: (context) => getIt<CharactersBloc>(),
        ),
      ],
      child: const FavoritesView(),
    );
  }
}
