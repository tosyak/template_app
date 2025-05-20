import 'package:flutter/services.dart';
import 'package:ricknotmorty/core/localization/locale_cubit/data/locale_model.dart';
import 'package:ricknotmorty/core/network/dio/dio_client.dart';
import 'package:ricknotmorty/core/services/logger/app_logger.dart';

/// Abstract data source for managing language-related operations
///
/// This data source provides an interface for fetching language translations
/// and extends [DioClient] for potential network-related functionality.
/// Implementations should override [fetchLanguages] to retrieve language data.
abstract class LanguageDataSource extends DioClient with AppLogger {
  Future<Map<String, Map<String, String>>> fetchLanguages();
}

class LanguageDataSourceImpl extends LanguageDataSource {
  @override
  Future<Map<String, Map<String, String>>> fetchLanguages() async {
    try {
      final res = await rootBundle.loadString('assets/locale.json');
      return languageModelFromJson(res);
    } catch (e) {
      log.severe('Error loading or parsing locale.json: $e');
      rethrow;
    }
  }
}
