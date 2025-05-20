import 'dart:ui';

import 'package:flutter/material.dart';

/// A widget that observes the lifecycle of the app and provides a mechanism to detect app state changes.
/// 
/// This widget wraps another widget and tracks the app's lifecycle states, 
/// allowing for actions to be taken when the app is paused, resumed, or in other states.
/// 
/// The [child] parameter represents the widget to be displayed and monitored.
class LifecycleObserver extends StatefulWidget {
  const LifecycleObserver({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  State<LifecycleObserver> createState() => _LifecycleObserverState();
}

class _LifecycleObserverState extends State<LifecycleObserver>
    with WidgetsBindingObserver {
  final _blurNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        _blurNotifier.value = false;
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        _blurNotifier.value = true;
        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        ValueListenableBuilder(
          valueListenable: _blurNotifier,
          builder: (context, bool value, child) {
            if (value) {
              return BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  height: MediaQuery.sizeOf(context).height,
                  width: MediaQuery.sizeOf(context).width,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200..withAlpha(25),
                  ),
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ],
    );
  }
}
