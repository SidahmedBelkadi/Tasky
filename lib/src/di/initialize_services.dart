import 'package:get_it/get_it.dart';
import 'package:tasky/src/di/auth_dependencies.dart';
import 'package:tasky/src/di/externel_dependencies.dart';
import 'core_dependencies.dart';
import 'task_dependencies.dart';
import 'profile_dependencies.dart';

final serviceLocator = GetIt.instance;

Future<void> initializeAppDependencies() async {
  await initExternalDependencies();
  initCoreDependencies();
  initAuthDependencies();
  initTaskDependencies();
  initProfileDependencies();
}
