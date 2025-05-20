import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ricknotmorty/core/error/failures.dart';
import 'package:ricknotmorty/domain/entities/character_entity.dart';
import 'package:ricknotmorty/domain/entities/info_entity.dart';
import 'package:ricknotmorty/domain/entities/location_entity.dart';
import 'package:ricknotmorty/domain/usecases/get_character_usecase.dart';
import 'package:ricknotmorty/features/characters_list/bloc/characters_bloc.dart';

class MockGetCharactersUseCase extends Mock implements GetCharactersUseCase {}

void main() {
  late CharactersBloc bloc;
  late MockGetCharactersUseCase mockUseCase;

  // Sample test data
  final tCharacterResponse = CharacterResponse(
    info: Info(count: 20, pages: 2, next: "https://nextpage.com", prev: null),
    results: [
      Character(
        id: 1,
        name: "Rick Sanchez",
        status: "Alive",
        species: "Human",
        type: "",
        gender: "Male",
        origin: Location(name: "Earth", url: ""),
        location: Location(name: "Earth", url: ""),
        image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
        episode: ["https://rickandmortyapi.com/api/episode/1"],
        url: "https://rickandmortyapi.com/api/character/1",
        created: DateTime(2017 - 11 - 04),
      ),
      Character(
        id: 2,
        name: "Morty Smith",
        status: "Alive",
        species: "Human",
        type: "",
        gender: "Male",
        origin: Location(name: "Earth", url: ""),
        location: Location(name: "Earth", url: ""),
        image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg",
        episode: ["https://rickandmortyapi.com/api/episode/1"],
        url: "https://rickandmortyapi.com/api/character/2",
        created: DateTime(2017 - 11 - 04),
      ),
    ],
  );

  final tFavoriteIds = [1, 3, 5];

  // Error cases
  final tServerFailure = ServerFailure("Server error");
  final tCacheFailure = CacheFailure("Cache error");

  setUp(() {
    mockUseCase = MockGetCharactersUseCase();
    bloc = CharactersBloc(usecase: mockUseCase);

    // Register fallback values for any parameter types used in the mocked methods
    registerFallbackValue(1); // For page parameter
  });

  tearDown(() {
    bloc.close();
  });

  test('initial state should be Initial', () {
    expect(bloc.state, const CharactersState.initial());
  });

  group('GetCharactersList event', () {
    test(
        'should emit [Loading, CharacterResponseLoaded] when data is gotten successfully',
        () async {
      // Arrange
      when(() => mockUseCase.getCharactersList(
            page: any(named: 'page'),
            name: any(named: 'name'),
            status: any(named: 'status'),
            species: any(named: 'species'),
            type: any(named: 'type'),
            gender: any(named: 'gender'),
          )).thenAnswer((_) async => Right(tCharacterResponse));

      when(() => mockUseCase.getFavoriteIds())
          .thenAnswer((_) async => Right(tFavoriteIds));

      // Assert later
      final expected = [
        const CharactersState.loading(),
        CharactersState.characterResponse(
          characters: tCharacterResponse,
          favoriteIds: tFavoriteIds,
        ),
      ];

      expectLater(bloc.stream, emitsInOrder(expected));

      // Act
      bloc.add(const CharactersEvent.getCharactersList(pageKey: 1));
    });

    test('should emit [Loading, Error] when getting characters fails',
        () async {
      // Arrange
      when(() => mockUseCase.getCharactersList(
            page: any(named: 'page'),
            name: any(named: 'name'),
            status: any(named: 'status'),
            species: any(named: 'species'),
            type: any(named: 'type'),
            gender: any(named: 'gender'),
          )).thenAnswer((_) async => Left(tServerFailure));

      when(() => mockUseCase.getFavoriteIds())
          .thenAnswer((_) async => Right(tFavoriteIds));

      // Assert later
      final expected = [
        const CharactersState.loading(),
        CharactersState.error(tServerFailure.message),
      ];

      expectLater(bloc.stream, emitsInOrder(expected));

      // Act
      bloc.add(const CharactersEvent.getCharactersList(pageKey: 1));
    });

    test('should emit [Loading, Error] when getting favorites fails', () async {
      // Arrange
      when(() => mockUseCase.getCharactersList(
            page: any(named: 'page'),
            name: any(named: 'name'),
            status: any(named: 'status'),
            species: any(named: 'species'),
            type: any(named: 'type'),
            gender: any(named: 'gender'),
          )).thenAnswer((_) async => Right(tCharacterResponse));

      when(() => mockUseCase.getFavoriteIds())
          .thenAnswer((_) async => Left(tCacheFailure));

      // Assert later
      final expected = [
        const CharactersState.loading(),
        CharactersState.error(tCacheFailure.message),
      ];

      expectLater(bloc.stream, emitsInOrder(expected));

      // Act
      bloc.add(const CharactersEvent.getCharactersList(pageKey: 1));
    });
  });

  group('AddFavorite event', () {
    test('should call usecase.addFavorite with correct id', () async {
      // Arrange
      when(() => mockUseCase.addFavorite(any()))
          .thenAnswer((_) async => Right(null));

      // Act
      bloc.add(const CharactersEvent.addFavorite(1));
      await untilCalled(() => mockUseCase.addFavorite(any()));

      // Assert
      verify(() => mockUseCase.addFavorite(1)).called(1);
    });
  });

  group('RemoveFavorite event', () {
    test('should call usecase.removeFavorite with correct id', () async {
      // Arrange
      when(() => mockUseCase.removeFavorite(any()))
          .thenAnswer((_) async => Right(null));

      // Act
      bloc.add(const CharactersEvent.removeFavorite(1));
      await untilCalled(() => mockUseCase.removeFavorite(any()));

      // Assert
      verify(() => mockUseCase.removeFavorite(1)).called(1);
    });
  });
}
