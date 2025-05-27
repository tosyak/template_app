import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ricknotmorty/domain/entities/character_entity.dart';
import 'package:ricknotmorty/features/character_details/ui/views/character_details_view.dart';

@RoutePage(name: "CharacterDetailsRoute")
class CharacterDetailsScreen extends StatelessWidget {
  static const routeName = "/character-details";
  final Character character;

  const CharacterDetailsScreen({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return CharacterDetailsView(character: character);
  }
}
