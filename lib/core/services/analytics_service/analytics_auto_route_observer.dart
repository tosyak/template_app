import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ricknotmorty/core/services/analytics_service/analytics_service.dart';

/// An [AutoRouterObserver] that logs screen views to an analytics service.
///
/// This observer automatically tracks screen navigation events by logging
/// screen views with the provided [AnalyticsService]. It uses a debounce
/// mechanism to prevent rapid, duplicate logging of screen views.
///
/// The observer extracts route names and paths from various route types
/// and logs them with the analytics service when navigation occurs.
class AnalyticsAutoRouteObserver extends AutoRouterObserver {
  final AnalyticsService _analyticsService;
  Timer? _debounceTimer;

  AnalyticsAutoRouteObserver(this._analyticsService);

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _debounceLogScreenView(route);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    if (newRoute != null) {
      _debounceLogScreenView(newRoute);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (previousRoute != null) {
      _debounceLogScreenView(previousRoute);
    }
  }

  void _debounceLogScreenView(Route<dynamic> route) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      _logScreenView(route);
    });
  }

  void _logScreenView(Route<dynamic> route) {
    String? routeName;
    String? routePath;

    if (route.settings is PageRouteInfo) {
      final routeInfo = route.settings as PageRouteInfo;
      routeName = routeInfo.routeName;
    } else if (route.settings is AutoRoutePage) {
      final autoRoutePage = route.settings as AutoRoutePage;
      routeName = autoRoutePage.routeData.name;
      routePath = autoRoutePage.routeData.path;
    } else {
      routeName = route.settings.name;
      routePath = route.settings.name;
    }

    if (routeName != null) {
      _analyticsService.logScreenView(
        screenName: routeName,
        screenClass: routePath ?? routeName,
      );
    }
  }
}
