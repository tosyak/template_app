import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/services.dart';
import 'package:ricknotmorty/core/services/logger/app_logger.dart';

/// Service responsible for handling deep links in the application.
///
/// Provides methods to initialize deep link handling, listen to incoming links,
/// and manage the lifecycle of deep link processing.

abstract class DeepLinkService {
  Stream<Uri> get links;
  Future<void> initialize();
  void dispose();
}

/// Concrete implementation of [DeepLinkService] using [app_links] package.
class AppLinksService with AppLogger implements DeepLinkService {
  final AppLinks _appLinks;

  // Stream controller for deep links
  final _linkController = StreamController<Uri>.broadcast();

  // Expose a stream of all recognized links
  @override
  Stream<Uri> get links => _linkController.stream;

  AppLinksService(this._appLinks);

  @override
  Future<void> initialize() async {
    await _setupLinkHandlers();
  }

  Future<void> _setupLinkHandlers() async {
    try {
      final initialLink = await _appLinks.getInitialLink();
      if (initialLink != null) {
        _handleIncomingLink(initialLink);
      }

      _appLinks.uriLinkStream.listen(
        _handleIncomingLink,
        onError: (error) => log.severe('Link stream error: $error'),
      );
    } on PlatformException catch (e) {
      log.severe('Failed to initialize app links: $e');
    }
  }

  void _handleIncomingLink(Uri link) {
    if (link.toString().isEmpty) return;

    final isMaskedDynamicLink = _isMaskedLink(link);
    if (isMaskedDynamicLink || _isSpecialPaymentLink(link)) {
      final extracted = _extractLinkParam(link);
      _linkController.add(extracted);
      _logLink('extracted', extracted);
    } else {
      _linkController.add(link);
      _logLink('normal', link);
    }
  }

  bool _isMaskedLink(Uri link) {
    return [
      'https://rickandmortyapi.com/',
      'https://www.rickandmortyapi.com/',
    ].any((base) => link.toString().startsWith(base));
  }

  bool _isSpecialPaymentLink(Uri link) {
    return link.host == 'special';
  }

  Uri _extractLinkParam(Uri link) {
    try {
      final extracted = link.queryParameters['link'];
      return extracted != null ? Uri.parse(extracted) : link;
    } catch (_) {
      return link;
    }
  }

  void _logLink(String type, Uri link) {
    log.info('Received deep link [$type]: $link');
  }

  @override
  void dispose() {
    _linkController.close();
  }
}
