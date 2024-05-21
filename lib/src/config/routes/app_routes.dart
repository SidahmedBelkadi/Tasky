import 'package:flutter/material.dart';
import 'package:todo_app/src/core/animation/routes_animation_manager.dart';

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
        return RoutesAnimationManager.fadeTransition(
          const OnBoardingScreen(),
        );
      case Routes.signIn:
        return RoutesAnimationManager.scaleTransition(
          const SignInScreen(),
        );
      case Routes.signUp:
        return RoutesAnimationManager.scaleTransition(
          const SignUpScreen(),
        );
      case Routes.tasksHome:
        return RoutesAnimationManager.slideFromRightTransition(
          const TasksScreen(),
        );
      case Routes.addTask:
        return RoutesAnimationManager.slideFromBottomTransition(
          const AddTaskScreen(),
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
