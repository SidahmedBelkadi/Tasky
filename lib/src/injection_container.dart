import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'core/api/dio_consumer.dart';
import 'core/api/dio_interceptor.dart';
import 'core/utils/helpers/launch_helper.dart';
import 'core/utils/networking/network_info.dart';
import 'features/auth/data/data_sources/local/authentication_local_data_source.dart';
import 'features/auth/data/data_sources/remote/authentication_remote_data_source.dart';
import 'features/auth/data/repositories/authentication_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/use_cases/sign_up_usecase.dart';
import 'features/auth/presentation/sign_up/cubit/sign_up_cubit.dart';

final serviceLocator = GetIt.instance;

Future<void> initializeAppDependencies() async {
  // ================ External ================ //
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton(() => sharedPreferences);

  final dio = Dio();
  serviceLocator.registerLazySingleton(() => dio);
  serviceLocator.registerLazySingleton<DioInterceptor>(() => DioInterceptor(
        authLocalDataSource: serviceLocator(),
        client: dio,
      ));
  serviceLocator.registerLazySingleton(() => LogInterceptor());
  serviceLocator.registerLazySingleton<DioConsumer>(() => DioConsumer(client: dio));

  // ================ Core ================ //
  serviceLocator
      .registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(connectivity: Connectivity()));

  // ================ Utils ================ //
  serviceLocator.registerLazySingleton(
    () => LaunchHelper(sharedPreferences: serviceLocator()),
  );

  // ================ Data Sources ================ //
  serviceLocator.registerLazySingleton<AuthenticationRemoteDataSource>(
    () => AuthenticationRemoteDataSourceImpl(dioConsumer: serviceLocator()),
  );

  serviceLocator.registerLazySingleton<AuthenticationLocalDataSource>(
    () => AuthenticationLocalDataSourceImpl(sharedPreferences: serviceLocator()),
  );

  // ================ Repositories ================ //
  serviceLocator.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(
      authenticationRemoteDataSource: serviceLocator(),
      networkInfo: serviceLocator(),
    ),
  );

  // ================ Use Cases ================ //
  serviceLocator.registerLazySingleton(() => SignUpUseCase(repository: serviceLocator()));

  // ================ Blocs ================ //
  serviceLocator.registerFactory(
      () => SignUpCubit(signUpUseCase: serviceLocator(), localDataSource: serviceLocator()));
}
