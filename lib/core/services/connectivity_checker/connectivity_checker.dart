import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:ricknotmorty/core/service_locator/service_locator.dart';
import 'package:ricknotmorty/features/no_internet/no_internet_connection_page.dart';
import 'package:ricknotmorty/features/splash/splash_screen.dart';
import 'package:ricknotmorty/features/widgets/error_dialog.dart';

/// A widget that checks the device's internet connectivity and handles offline scenarios.
///
/// This widget wraps its child widget and monitors the connectivity status.
/// When the device goes offline, it can trigger appropriate UI or navigation actions.
class ConnectionChecker extends StatefulWidget {
  const ConnectionChecker({required this.child, super.key});

  final Widget child;

  @override
  State<ConnectionChecker> createState() => _ConnectionCheckerState();
}

class _ConnectionCheckerState extends State<ConnectionChecker> {
  final _connectivity = getIt<Connectivity>();
  late final StreamSubscription _sub;
  bool? _isOffline;

  Future<void> _init() async {
    _sub = _connectivity.onConnectivityChanged.listen((result) {
      if (result.contains(ConnectivityResult.none)) {
        Future.delayed(const Duration(seconds: 3), () async {
          final onlineResult = await _connectivity.checkConnectivity();
          if (onlineResult.contains(ConnectivityResult.none)) {
            if (_isOffline == null || !_isOffline!) {
              setState(() {
                _isOffline = true;
              });
            }
          } else {
            if (_isOffline ?? true) {
              setState(() {
                _isOffline = false;
              });
            }
          }
        });
      } else {
        if (_isOffline ?? true) {
          setState(() => _isOffline = false);
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: () async {
        if (_isOffline == null) {
          final result = await _connectivity.checkConnectivity();
          if (result.contains(ConnectivityResult.none)) {
            _isOffline = true;
          } else {
            _isOffline = false;
          }
        }

        return _isOffline;
      }(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SplashView();

        return _isOffline!
            ? NoInternetConnectionPage(
                onRecheckTapped: () async {
                  final List<ConnectivityResult> result =
                      await _connectivity.checkConnectivity();
                  if (!result.contains(ConnectivityResult.none)) {
                    if (_isOffline ?? true) {
                      setState(() {
                        _isOffline = false;
                      });
                    }
                  } else {
                    if (!context.mounted) return;
                    showGeneralDialog(
                      context: context,
                      pageBuilder: (context, anim1, anim2) {
                        return const ErrorDialog(
                          errorDescription: 'nooo conection',
                        );
                      },
                    );
                  }
                },
              )
            : widget.child;
      },
    );
  }
}
