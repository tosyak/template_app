import 'dart:async';

import 'package:path/path.dart';
import 'package:ricknotmorty/core/error/exceptions.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;
  static const _databaseVersion = 1;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    try {
      String path = join(await getDatabasesPath(), 'rick_morty_database.db');
      return await openDatabase(
        path,
        version: _databaseVersion,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade,
      );
    } catch (e) {
      throw AppDatabaseException('Failed to initialize database: $e');
    }
  }

  Future<void> _onCreate(Database db, int version) async {
    await _createTables(db);
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      await db.execute('DROP TABLE IF EXISTS character_episode');
      await db.execute('DROP TABLE IF EXISTS characters');
      await db.execute('DROP TABLE IF EXISTS locations');
      await db.execute('DROP TABLE IF EXISTS episodes');
      await _createTables(db);
    }
  }

  Future<void> _createTables(Database db) async {
    await db.transaction((txn) async {
      // Characters table with foreign keys to locations
      await txn.execute('''
        CREATE TABLE characters(
          id INTEGER PRIMARY KEY,
          name TEXT,
          status TEXT,
          species TEXT,
          type TEXT,
          gender TEXT,
          origin_id INTEGER,
          location_id INTEGER,
          image TEXT,
          url TEXT,
          created TEXT,
          last_fetched INTEGER,
          FOREIGN KEY (origin_id) REFERENCES locations (id),
          FOREIGN KEY (location_id) REFERENCES locations (id)
        )
      ''');

      // Locations table (will store both origin and location data)
      await txn.execute('''
        CREATE TABLE locations(
          id INTEGER PRIMARY KEY,
          name TEXT NOT NULL,
          url TEXT UNIQUE NOT NULL,
          last_fetched INTEGER
        )
      ''');

      // Episodes table
      await txn.execute('''
        CREATE TABLE episodes(
          id INTEGER PRIMARY KEY,
          url TEXT UNIQUE NOT NULL,
          name TEXT,
          last_fetched INTEGER
        )
      ''');

      // Character-Episode relation table (many-to-many)
      await txn.execute('''
        CREATE TABLE character_episode(
          character_id INTEGER,
          episode_id INTEGER,
          PRIMARY KEY (character_id, episode_id),
          FOREIGN KEY (character_id) REFERENCES characters (id) ON DELETE CASCADE,
          FOREIGN KEY (episode_id) REFERENCES episodes (id) ON DELETE CASCADE
        )
      ''');

      // Favorites table
      await db.execute('''
      CREATE TABLE favorites (
        id INTEGER PRIMARY KEY       
        )
      ''');
    });
  }

  // Batch insert characters with their relationships
  Future<void> batchInsertCharacters(
      List<Map<String, dynamic>> characters) async {
    final db = await database;

    await db.transaction((txn) async {
      for (var character in characters) {
        // Extract origin and location IDs
        int? originId;
        if (character['origin'] != null &&
            character['origin']['url'] != null &&
            character['origin']['url'].isNotEmpty) {
          final originUrl = character['origin']['url'];
          originId = extractIdFromUrl(originUrl);

          if (originId != null) {
            await txn.insert(
              'locations',
              {
                'id': originId,
                'name': character['origin']['name'],
                'url': originUrl,
                'last_fetched': DateTime.now().millisecondsSinceEpoch,
              },
              conflictAlgorithm: ConflictAlgorithm.replace,
            );
          }
        }

        int? locationId;
        if (character['location'] != null &&
            character['location']['url'] != null &&
            character['location']['url'].isNotEmpty) {
          final locationUrl = character['location']['url'];
          locationId = extractIdFromUrl(locationUrl);

          if (locationId != null) {
            await txn.insert(
              'locations',
              {
                'id': locationId,
                'name': character['location']['name'],
                'url': locationUrl,
                'last_fetched': DateTime.now().millisecondsSinceEpoch,
              },
              conflictAlgorithm: ConflictAlgorithm.replace,
            );
          }
        }

        // Insert character
        await txn.insert(
          'characters',
          {
            'id': character['id'],
            'name': character['name'],
            'status': character['status'],
            'species': character['species'],
            'type': character['type'],
            'gender': character['gender'],
            'origin_id': originId,
            'location_id': locationId,
            'image': character['image'],
            'url': character['url'],
            'created': character['created'],
            'last_fetched': DateTime.now().millisecondsSinceEpoch,
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );

        // Handle episodes
        if (character['episode'] != null && character['episode'] is List) {
          for (var episodeUrl in character['episode']) {
            final episodeId = extractIdFromUrl(episodeUrl);
            if (episodeId != null) {
              // Insert episode with minimal information
              await txn.insert(
                'episodes',
                {
                  'id': episodeId,
                  'url': episodeUrl,
                  'last_fetched': DateTime.now().millisecondsSinceEpoch,
                },
                conflictAlgorithm: ConflictAlgorithm.ignore,
              );

              // Create character-episode relationship
              await txn.insert(
                'character_episode',
                {
                  'character_id': character['id'],
                  'episode_id': episodeId,
                },
                conflictAlgorithm: ConflictAlgorithm.replace,
              );
            }
          }
        }
      }
    });
  }

  // Get character with all relationships
  Future<Map<String, dynamic>?> getCharacterWithRelations(int id) async {
    final db = await database;

    final characterResults = await db.query(
      'characters',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (characterResults.isEmpty) {
      return null;
    }

    final character = characterResults.first;

    // Get origin location
    Map<String, dynamic>? origin;
    if (character['origin_id'] != null) {
      final originResults = await db.query(
        'locations',
        where: 'id = ?',
        whereArgs: [character['origin_id']],
      );

      if (originResults.isNotEmpty) {
        origin = {
          'name': originResults.first['name'],
          'url': originResults.first['url'],
        };
      }
    }

    // Get current location
    Map<String, dynamic>? location;
    if (character['location_id'] != null) {
      final locationResults = await db.query(
        'locations',
        where: 'id = ?',
        whereArgs: [character['location_id']],
      );

      if (locationResults.isNotEmpty) {
        location = {
          'name': locationResults.first['name'],
          'url': locationResults.first['url'],
        };
      }
    }

    // Get episodes
    final episodeJoinResults = await db.rawQuery('''
      SELECT e.url 
      FROM episodes e
      JOIN character_episode ce ON e.id = ce.episode_id
      WHERE ce.character_id = ?
    ''', [id]);

    List<String> episodes =
        episodeJoinResults.map((e) => e['url'] as String).toList();

    // Combine all data
    return {
      ...character,
      'origin': origin ?? {'name': 'unknown', 'url': ''},
      'location': location ?? {'name': 'unknown', 'url': ''},
      'episode': episodes,
    };
  }

  // Get all characters with all relationships
  Future<List<Map<String, dynamic>>> query(
    String table, {
    List<String>? columns,
    String? where,
    List<dynamic>? whereArgs,
    String? orderBy,
    int? limit,
    int? offset,
  }) async {
    try {
      final db = await database;
      return await db.query(
        table,
        columns: columns,
        where: where,
        whereArgs: whereArgs,
        orderBy: orderBy,
        limit: limit,
        offset: offset,
      );
    } catch (e) {
      throw AppDatabaseException('Failed to query $table: $e');
    }
  }

  // Helper methods to extract IDs from URLs
  int? extractIdFromUrl(String url) {
    final regex = RegExp(r'/(\d+)$');
    final match = regex.firstMatch(url);
    if (match != null && match.groupCount >= 1) {
      return int.tryParse(match.group(1)!);
    }
    return null;
  }

  // Add a character to favorites
  Future<void> addFavorite(int characterId) async {
    final db = await database;
    await db.insert(
      'favorites',
      {'id': characterId},
      conflictAlgorithm: ConflictAlgorithm.ignore, // Avoid duplicates
    );
  }

// Remove a character from favorites
  Future<void> removeFavorite(int characterId) async {
    final db = await database;
    await db.delete(
      'favorites',
      where: 'id = ?',
      whereArgs: [characterId],
    );
  }

  // Get all favorite character IDs
  Future<List<int>> getFavoriteIds() async {
    final db = await database;
    final result = await db.query('favorites', columns: ['id']);
    return result.map((row) => row['id'] as int).toList();
  }

// Check if character is favorite
  Future<bool> isFavorite(int characterId) async {
    final db = await database;
    final result = await db.query(
      'favorites',
      where: 'id = ?',
      whereArgs: [characterId],
      limit: 1,
    );
    return result.isNotEmpty;
  }

// Get all favorite characters (with full details)
  Future<List<Map<String, dynamic>>> getFavoriteCharacters() async {
    final db = await database;

    final idsResult = await db.query('favorites');
    final ids = idsResult.map((e) => e['id'] as int).toList();

    if (ids.isEmpty) return [];

    final placeholders = List.filled(ids.length, '?').join(', ');
    final characters = await db.rawQuery(
      'SELECT * FROM characters WHERE id IN ($placeholders)',
      ids,
    );

    // Optionally join locations/episodes if needed
    return characters;
  }
}
