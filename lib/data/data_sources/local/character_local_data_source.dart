import 'package:ricknotmorty/core/data_base/sql_bd.dart';
import 'package:ricknotmorty/core/error/exceptions.dart';
import 'package:ricknotmorty/data/models/character_model/character_model.dart';
import 'package:sqflite/sqflite.dart';

/// Abstract data source for local character storage and retrieval operations
/// Provides methods for caching, fetching, and managing character data locally
/// Supports filtering, pagination, and favorite character management
abstract class CharacterLocalDataSource {
  Future<void> cacheCharacters(List<CharacterModel> characters);
  Future<List<CharacterModel>> getCharacters({
    int page = 1,
    int limit = 20,
    String? name,
    String? status,
    String? species,
    String? type,
    String? gender,
  });
  Future<int> getCharactersCount({
    String? name,
    String? status,
    String? species,
    String? type,
    String? gender,
  });
  Future<List<int>> getFavoriteIds();
  Future<void> addFavorite(int id);
  Future<void> removeFavorite(int id);
  Future<List<CharacterModel>> getFavoriteCharactersList();
}

class CharacterLocalDataSourceImpl implements CharacterLocalDataSource {
  CharacterLocalDataSourceImpl();

  final DatabaseHelper dbHelper = DatabaseHelper();

  @override
  Future<void> cacheCharacters(List<CharacterModel> characters) async {
    try {
      final characterMaps = characters.map((character) {
        final Map<String, dynamic> characterMap = character.toJson();

        if (characterMap['origin'] is! Map) {
          characterMap['origin'] = {
            'name': character.origin.name,
            'url': character.origin.url,
          };
        }

        if (characterMap['location'] is! Map) {
          characterMap['location'] = {
            'name': character.location.name,
            'url': character.location.url,
          };
        }

        if (characterMap['episode'] is! List) {
          characterMap['episode'] = character.episode;
        }

        return characterMap;
      }).toList();

      await dbHelper.batchInsertCharacters(characterMaps);
    } catch (e) {
      throw AppDatabaseException('Failed to cache characters: $e');
    }
  }

  @override
  Future<List<CharacterModel>> getCharacters({
    int page = 1,
    int limit = 20,
    String? name,
    String? status,
    String? species,
    String? type,
    String? gender,
  }) async {
    try {
      final offset = (page - 1) * limit;

      final conditions = <String>[];
      final arguments = <dynamic>[];

      if (name != null && name.isNotEmpty) {
        conditions.add("LOWER(name) LIKE LOWER(?)");
        arguments.add('%$name%');
      }
      if (status != null && status.isNotEmpty) {
        conditions.add("LOWER(status) = LOWER(?)");
        arguments.add(status);
      }
      if (species != null && species.isNotEmpty) {
        conditions.add("LOWER(species) = LOWER(?)");
        arguments.add(species);
      }
      if (type != null && type.isNotEmpty) {
        conditions.add("LOWER(type) = LOWER(?)");
        arguments.add(type);
      }
      if (gender != null && gender.isNotEmpty) {
        conditions.add("LOWER(gender) = LOWER(?)");
        arguments.add(gender);
      }

      final whereClause =
          conditions.isNotEmpty ? conditions.join(' AND ') : null;

      final charactersData = await dbHelper.query(
        'characters',
        where: whereClause,
        whereArgs: arguments.isNotEmpty ? arguments : null,
        orderBy: 'id ASC',
        limit: limit,
        offset: offset,
      );

      final characters = <CharacterModel>[];
      for (var data in charactersData) {
        final completeData = await dbHelper.getCharacterWithRelations(
          data['id'] as int,
        );
        if (completeData != null) {
          final character = CharacterModel.fromJson(completeData);
          characters.add(character);
        }
      }

      return characters;
    } catch (e) {
      throw AppDatabaseException('Failed to get characters: $e');
    }
  }

  @override
  Future<int> getCharactersCount({
    String? name,
    String? status,
    String? species,
    String? type,
    String? gender,
  }) async {
    try {
      final conditions = <String>[];
      final arguments = <dynamic>[];

      if (name != null && name.isNotEmpty) {
        conditions.add("LOWER(name) LIKE LOWER(?)");
        arguments.add('%$name%');
      }
      if (status != null && status.isNotEmpty) {
        conditions.add("LOWER(status) = LOWER(?)");
        arguments.add(status);
      }
      if (species != null && species.isNotEmpty) {
        conditions.add("LOWER(species) = LOWER(?)");
        arguments.add(species);
      }
      if (type != null && type.isNotEmpty) {
        conditions.add("LOWER(type) = LOWER(?)");
        arguments.add(type);
      }
      if (gender != null && gender.isNotEmpty) {
        conditions.add("LOWER(gender) = LOWER(?)");
        arguments.add(gender);
      }

      final whereClause =
          conditions.isNotEmpty ? conditions.join(' AND ') : null;

      final result = await dbHelper.query(
        'characters',
        columns: ['COUNT(*) as count'],
        where: whereClause,
        whereArgs: arguments.isNotEmpty ? arguments : null,
      );

      return Sqflite.firstIntValue(result) ?? 0;
    } catch (e) {
      throw AppDatabaseException('Failed to get characters count: $e');
    }
  }

  @override
  Future<List<int>> getFavoriteIds() async {
    try {
      final result = await dbHelper.getFavoriteIds();
      return result;
    } catch (e) {
      throw AppDatabaseException('Failed to get favorite IDs: $e');
    }
  }

  @override
  Future<void> addFavorite(int id) async {
    try {
      await dbHelper.addFavorite(id);
    } catch (e) {
      throw AppDatabaseException('Failed to add favorite: $e');
    }
  }

  @override
  Future<void> removeFavorite(int id) async {
    try {
      await dbHelper.removeFavorite(id);
    } catch (e) {
      throw AppDatabaseException('Failed to remove favorite: $e');
    }
  }

  @override
  Future<List<CharacterModel>> getFavoriteCharactersList() async {
    try {
      final favoriteIds = await getFavoriteIds();

      if (favoriteIds.isEmpty) return [];

      List<CharacterModel> favoriteCharacters = [];

      for (final id in favoriteIds) {
        final character = await dbHelper.getCharacterWithRelations(id);
        if (character != null) {
          final characterModel = CharacterModel.fromJson(character);
          favoriteCharacters.add(characterModel);
        }
      }

      return favoriteCharacters;
    } catch (e) {
      throw AppDatabaseException('Failed to get favorite characters list: $e');
    }
  }
}
