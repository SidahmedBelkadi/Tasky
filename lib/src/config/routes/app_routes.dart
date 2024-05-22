import 'package:flutter/material.dart';

import '../../core/animation/routes_animation_manager.dart';
import '../../core/utils/app_strings.dart';
import '../../features/on_boarding/presentation/screens/onboarding_screen.dart';
import '../../features/profile/presentation/profile_screen.dart';
import '../../features/auth/presentation/sign_in/sign_in_screen.dart';
import '../../features/auth/presentation/sign_up/sign_up_screen.dart';
import '../../features/task/presentation/add_task/add_task_screen.dart';
import '../../features/task/presentation/task_details.dart/task_details_screen.dart';
import '../../features/task/presentation/task_home/tasks_screen.dart';

class Routes {
  static const String initialRoute = '/';
  static const String signIn = '/sign_in';
  static const String signUp = '/sign_up';
  static const String tasksHome = '/tasks_home';
  static const String addTask = '/add_task';
  static const String taskDetails = '/task_details';
  static const String profile = '/profile';
}

class AppRoutes {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    // ignore: unused_local_variable
    final args = routeSettings.arguments;

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

      case Routes.taskDetails:
        return RoutesAnimationManager.slideFromBottomTransition(
          const TaskDetailsScreen(),
        );

      case Routes.profile:
        return RoutesAnimationManager.slideFromBottomTransition(
          const ProfileScreen(),
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
