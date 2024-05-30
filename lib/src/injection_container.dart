import 'package:get_it/get_it.dart';
import 'package:tasky/src/core/di/auth_dependencies.dart';
import 'package:tasky/src/core/di/core_dependencies.dart';
import 'package:tasky/src/core/di/externel_dependencies.dart';
import 'package:tasky/src/core/di/profile_dependencies.dart';
import 'package:tasky/src/core/di/task_dependencies.dart';

final serviceLocator = GetIt.instance;

Future<void> initializeAppDependencies() async {
  await initExternalDependencies();
  initCoreDependencies();
  initAuthDependencies();
  initTaskDependencies();
  initProfileDependencies();
}
