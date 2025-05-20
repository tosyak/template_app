import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:ricknotmorty/core/routing/router.dart';
import 'package:ricknotmorty/core/routing/router.gr.dart';
import 'package:ricknotmorty/core/service_locator/service_locator.dart';
import 'package:ricknotmorty/core/services/deep_link_service/deep_link_service.dart';
import 'package:ricknotmorty/features/splash/bloc/splash_bloc.dart';

@RoutePage(name: 'Splash')
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  static const String routeName = '/splash';

  @override
  Widget build(BuildContext context) {
    return const SplashView();
  }
}

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    void navigateToMainScreen() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        router.pushAndPopUntil(
          const MainPageRoute(),
          predicate: (route) => false,
        );
      });
    }

    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) async {
        if (state is SplashLoaded) {
          final deepLinkService = getIt<DeepLinkService>();

          deepLinkService.links.listen((uri) {
            navigateToMainScreen();
          });
          navigateToMainScreen();
        }
      },
      child: Scaffold(
        body: Center(
          child: Lottie.asset('assets/lottie/morty.json'),
        ),
      ),
    );
  }
}
