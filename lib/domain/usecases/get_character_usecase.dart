import 'package:dartz/dartz.dart';
import 'package:ricknotmorty/core/error/failures.dart';
import 'package:ricknotmorty/domain/entities/character_entity.dart';
import 'package:ricknotmorty/domain/repositories/character_repository.dart';

/// Use case for retrieving and managing characters from a repository
///
/// Provides methods to fetch characters, manage favorites, and interact with character data
class GetCharactersUseCase {
  final CharacterRepository repository;

  GetCharactersUseCase({required this.repository});

  Future<Either<Failure, CharacterResponse>> getCharactersList({
    required int page,
    String? name,
    String? status,
    String? species,
    String? type,
    String? gender,
  }) async {
    return await repository.getCharactersList(
      page: page,
      name: name,
      status: status,
      species: species,
      type: type,
      gender: gender,
    );
  }

  Future<Either<Failure, List<int>>> getFavoriteIds() async {
    return await repository.getFavoriteIds();
  }

  Future<Either<Failure, void>> addFavorite(int id) async {
    return await repository.addFavorite(id);
  }

  Future<Either<Failure, void>> removeFavorite(int id) async {
    return await repository.removeFavorite(id);
  }

  Future<Either<Failure, List<Character>>> getFavoriteCharactersList() async {
    return await repository.getFavoriteCharactersList();
  }
}
