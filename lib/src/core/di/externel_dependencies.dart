import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final serviceLocator = GetIt.instance;

Future<void> initExternalDependencies() async {
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton(() => sharedPreferences);

  final dio = Dio();
  serviceLocator.registerLazySingleton(() => dio);
  serviceLocator.registerLazySingleton(() => LogInterceptor());
}
