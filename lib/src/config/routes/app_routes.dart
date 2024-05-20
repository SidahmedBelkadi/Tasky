import 'package:flutter/material.dart';

import '../../core/utils/app_strings.dart';
import '../../features/on_boarding/presentation/screens/onboarding_screen.dart';
import '../../features/sign_in/presentation/screens/sign_in_screen.dart';
import '../../features/sign_up/presentation/screens/sign_up_screen.dart';
import '../../features/task/presentation/add_task/add_task.dart';
import '../../features/task/presentation/task_home/tasks_screen.dart';

class Routes {
  static const String initialRoute = '/';
  static const String signIn = '/sign_in';
  static const String signUp = '/sign_up';
  static const String tasksHome = '/tasks_home';
  static const String addTask = '/add_task';
}

class AppRoutes {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.initialRoute:
        return _buildRouteWithAnimation(
          const OnBoardingScreen(),
        );
      case Routes.signIn:
        return _buildRouteWithAnimation(
          const SignInScreen(),
        );
      case Routes.signUp:
        return _buildRouteWithAnimation(
          const SignUpScreen(),
        );
      case Routes.tasksHome:
        return _buildRouteWithAnimation(
          const TasksScreen(),
        );
      case Routes.addTask:
        return _buildRouteWithAnimation(
          const AddTaskScreen(),
        );

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> _buildRouteWithAnimation(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
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
