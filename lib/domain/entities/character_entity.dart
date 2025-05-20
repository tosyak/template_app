import 'package:ricknotmorty/domain/entities/info_entity.dart';
import 'package:ricknotmorty/domain/entities/location_entity.dart';

class Character {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final Location origin;
  final Location location;
  final String image;
  final List<String> episode;
  final String url;
  final DateTime created;

  Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
    required this.url,
    required this.created,
  });
}

class CharacterResponse {
  final Info info;
  final List<Character> results;

  CharacterResponse({
    required this.info,
    required this.results,
  });
}
