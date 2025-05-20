import 'package:ricknotmorty/data/models/character_model/character_model.dart';
import 'package:ricknotmorty/data/models/info_model/info_model.dart';
import 'package:ricknotmorty/data/models/location_model/location_model.dart';
import 'package:ricknotmorty/domain/entities/character_entity.dart';
import 'package:ricknotmorty/domain/entities/info_entity.dart';
import 'package:ricknotmorty/domain/entities/location_entity.dart';

/// A mapper class responsible for converting between [CharacterResponseModel] and [CharacterResponse] data transfer objects.
///
/// This class provides static methods to transform character response data between model and entity representations,
/// facilitating data mapping in the application's data layer.
class CharacterResponseMapper {
  static CharacterResponse toEntity(CharacterResponseModel model) {
    return CharacterResponse(
      info: Info(
        count: model.info.count,
        pages: model.info.pages,
        next: model.info.next,
        prev: model.info.prev,
      ),
      results: CharacterMapper.toEntity(model.results),
    );
  }

  static CharacterResponseModel toModel(CharacterResponse response) {
    return CharacterResponseModel(
      info: InfoModel(
        count: response.info.count,
        pages: response.info.pages,
        next: response.info.next,
        prev: response.info.prev,
      ),
      results: CharacterMapper.toModel(response.results),
    );
  }
}

class CharacterMapper {
  static List<Character> toEntity(List<CharacterModel> models) {
    return models
        .map(
          (characterModel) => Character(
            id: characterModel.id,
            name: characterModel.name,
            status: characterModel.status,
            species: characterModel.species,
            type: characterModel.type,
            gender: characterModel.gender,
            origin: Location(
              name: characterModel.origin.name,
              url: characterModel.origin.url,
            ),
            location: Location(
              name: characterModel.location.name,
              url: characterModel.location.url,
            ),
            image: characterModel.image,
            episode: characterModel.episode,
            url: characterModel.url,
            created: characterModel.created,
          ),
        )
        .toList();
  }

  static List<CharacterModel> toModel(List<Character> characters) {
    return characters
        .map(
          (character) => CharacterModel(
            id: character.id,
            name: character.name,
            status: character.status,
            species: character.species,
            type: character.type,
            gender: character.gender,
            origin: LocationModel(
              name: character.origin.name,
              url: character.origin.url,
            ),
            location: LocationModel(
              name: character.location.name,
              url: character.location.url,
            ),
            image: character.image,
            episode: character.episode,
            url: character.url,
            created: character.created,
          ),
        )
        .toList();
  }
}
