import 'package:dartz/dartz.dart';
import 'package:ricknotmorty/core/error/failures.dart';
import 'package:ricknotmorty/domain/entities/character_entity.dart';

/// Repository for managing characters, providing methods to fetch, retrieve, and manage character-related data.
///
/// This abstract class defines the contract for character-related operations such as
/// fetching character lists, managing favorites, and interacting with character data.
abstract class CharacterRepository {
  Future<Either<Failure, CharacterResponse>> getCharactersList({
    required int page,
    String? name,
    String? status,
    String? species,
    String? type,
    String? gender,
  });

  Future<Either<Failure, List<int>>> getFavoriteIds();
  Future<Either<Failure, void>> addFavorite(int id);
  Future<Either<Failure, void>> removeFavorite(int id);
  Future<Either<Failure, List<Character>>> getFavoriteCharactersList();
}
