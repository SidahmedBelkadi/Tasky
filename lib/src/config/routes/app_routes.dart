import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/src/features/code_qr_scan/code_scanner.dart';
import 'package:tasky/src/features/profile/presentation/cubit/profile_cubit.dart';
import '../../features/task/presentation/add_task/cubit/add_task_cubit.dart';
import '../../features/task/presentation/task_details/cubit/task_detail_cubit.dart';
import '../../features/task/presentation/task_home/cubit/tasks_cubit.dart';

import '../../core/animation/routes_animation_manager.dart';
import '../../core/utils/resources/app_strings.dart';
import '../../features/auth/presentation/sign_in/cubit/sign_in_cubit.dart';
import '../../features/auth/presentation/sign_in/sign_in_screen.dart';
import '../../features/auth/presentation/sign_out/cubit/sign_out_cubit.dart';
import '../../features/auth/presentation/sign_up/cubit/sign_up_cubit.dart';
import '../../features/auth/presentation/sign_up/sign_up_screen.dart';
import '../../features/on_boarding/presentation/screens/onboarding_screen.dart';
import '../../features/profile/presentation/profile_screen.dart';
import '../../features/task/presentation/add_task/add_task_screen.dart';
import '../../features/task/presentation/task_details/task_details_screen.dart';
import '../../features/task/presentation/task_home/tasks_screen.dart';
import '../../injection_container.dart';

class Routes {
  static const String onBoarding = '/on_boarding';
  static const String signIn = '/sign_in';
  static const String signUp = '/sign_up';
  static const String tasksHome = '/tasks_home';
  static const String addTask = '/add_task';
  static const String taskDetails = '/task_details';
  static const String profile = '/profile';
  static const String qrCodeScanner = '/qr_code_scanner';
}

class AppRoutes {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments;

    switch (routeSettings.name) {
      case Routes.onBoarding:
        return RoutesAnimationManager.fadeTransition(
          const OnBoardingScreen(),
        );
      case Routes.signIn:
        return RoutesAnimationManager.slideFromRightTransition(
          BlocProvider(
            create: (context) => serviceLocator<SignInCubit>(),
            child: const SignInScreen(),
          ),
        );
      case Routes.signUp:
        return RoutesAnimationManager.slideFromRightTransition(
          BlocProvider(
            create: (_) => serviceLocator<SignUpCubit>(),
            child: const SignUpScreen(),
          ),
        );
      case Routes.tasksHome:
        return RoutesAnimationManager.slideFromRightTransition(
          MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => serviceLocator<TasksCubit>()..getAllTasks(isFirstTime: true),
              ),
              BlocProvider(
                create: (context) => serviceLocator<SignOutCubit>(),
              ),
            ],
            child: const TasksScreen(),
          ),
        );
      case Routes.addTask:
        return RoutesAnimationManager.slideFromRightTransition(
          BlocProvider(
            create: (context) => serviceLocator<AddTaskCubit>(),
            child: const AddTaskScreen(),
          ),
        );
      case Routes.taskDetails:
        return RoutesAnimationManager.slideFromRightTransition(
          args: args,
          BlocProvider(
            create: (context) => serviceLocator<TaskDetailCubit>(),
            child: const TaskDetailsScreen(),
          ),
        );
      case Routes.profile:
        return RoutesAnimationManager.slideFromRightTransition(
          BlocProvider(
            create: (context) => serviceLocator<ProfileCubit>()..getProfile(),
            child: const ProfileScreen(),
          ),
        );
      case Routes.qrCodeScanner:
        return RoutesAnimationManager.slideFromRightTransition(
          const QRCodeScannerScreen(),
        );
    }
    return null;
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
