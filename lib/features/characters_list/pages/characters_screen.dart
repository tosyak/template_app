import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricknotmorty/core/service_locator/service_locator.dart';
import 'package:ricknotmorty/features/characters_list/bloc/characters_bloc.dart';
import 'package:ricknotmorty/features/characters_list/views/characters_list_view.dart';

@RoutePage(name: "CharactersRoute")
class CharactersScreen extends StatelessWidget {
  static const routeName = 'characters-route';
  const CharactersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CharactersBloc>(),
      child: const CharactersView(),
    );
  }
}
