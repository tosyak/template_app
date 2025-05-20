import 'package:ricknotmorty/data/models/episode_model/episode_model.dart';
import 'package:ricknotmorty/domain/entities/episode_entity.dart';
import 'package:ricknotmorty/domain/entities/info_entity.dart';

/// A mapper class responsible for converting episode-related data models to domain entities.
///
/// This class provides static methods to transform data models into their corresponding
/// domain entity representations, facilitating clean separation between data and domain layers.
class EpisodeMapper {
  static EpisodeResponse toEntity(EpisodeResponseModel model) {
    return EpisodeResponse(
      info: GraphQLInfo(
        count: model.info.count,
        pages: model.info.pages,
        next: model.info.next,
        prev: model.info.prev,
      ),
      results: model.results
          .map(
            (episode) => Episode(
              id: episode.id,
              name: episode.name,
              airDate: episode.airDate,
              episode: episode.episode,
              created: episode.created,
            ),
          )
          .toList(),
    );
  }
}
