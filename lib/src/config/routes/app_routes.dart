import 'package:flutter/material.dart';
import 'package:todo_app/src/features/sign_in/presentation/screens/sign_in_screen.dart';
import 'package:todo_app/src/features/sign_up/presentation/screens/sign_up_screen.dart';
import '../../core/utils/app_strings.dart';
import '../../features/on_boarding/presentation/screens/onboarding_screen.dart';

class Routes {
  static const String initialRoute = '/';
  static const String signIn = '/sign_in';
  static const String signUp = '/sign_un';
}

class AppRoutes {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(
          builder: (_) => const OnBoardingScreen(),
        );
      case Routes.signIn:
        return MaterialPageRoute(
          builder: (_) => const SignInScreen(),
        );
      case Routes.signUp:
        return MaterialPageRoute(
          builder: (_) => const SignUpScreen(),
        );

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.noRouteFound),
        ),
        body: const Center(child: Text(AppStrings.noRouteFound)),
      ),
    );
  }
}
