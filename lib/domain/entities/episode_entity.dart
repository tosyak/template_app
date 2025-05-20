import 'package:ricknotmorty/domain/entities/info_entity.dart';

class Episode {
  final String id;
  final String name;
  final String airDate;
  final String episode;

  final DateTime created;

  Episode({
    required this.id,
    required this.name,
    required this.airDate,
    required this.episode,
    required this.created,
  });
}

class EpisodeResponse {
  final GraphQLInfo info;
  final List<Episode> results;

  EpisodeResponse({required this.info, required this.results});
}
