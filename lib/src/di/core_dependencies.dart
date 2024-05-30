import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:tasky/src/core/api/dio_consumer.dart';
import 'package:tasky/src/core/api/dio_interceptor.dart';
import 'package:tasky/src/core/utils/helpers/launch_helper.dart';
import 'package:tasky/src/core/utils/helpers/route_helper.dart';
import 'package:tasky/src/core/utils/networking/network_info.dart';
import 'package:tasky/src/features/auth/data/data_sources/local/authentication_local_data_source.dart';

final serviceLocator = GetIt.instance;

void initCoreDependencies() {
  serviceLocator.registerLazySingleton<DioInterceptor>(() => DioInterceptor(
        authLocalDataSource: serviceLocator(),
        client: serviceLocator(),
      ));
  serviceLocator.registerLazySingleton<DioConsumer>(() => DioConsumer(client: serviceLocator()));
  serviceLocator
      .registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(connectivity: Connectivity()));

  serviceLocator.registerLazySingleton(
    () => LaunchHelper(sharedPreferences: serviceLocator()),
  );

  serviceLocator.registerLazySingleton(() => InitialRouteHelper(
        launchHelper: serviceLocator<LaunchHelper>(),
        authLocalDataSource: serviceLocator<AuthenticationLocalDataSource>(),
      ));
}
