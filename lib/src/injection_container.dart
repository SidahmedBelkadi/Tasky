import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'features/task/data/data_sources/remote/tasks_remote_data_source.dart';
import 'features/task/data/repositories/tasks_repository_impl.dart';
import 'features/task/domain/repositories/tasks_repository.dart';
import 'features/task/domain/use_cases/create_task_use_case.dart';
import 'features/task/domain/use_cases/delete_task_use_case.dart';
import 'features/task/domain/use_cases/get_all_tasks.dart';
import 'features/task/domain/use_cases/get_one_task_use_case.dart';
import 'features/task/presentation/add_task/cubit/add_task_cubit.dart';
import 'features/task/presentation/task_details/cubit/task_detail_cubit.dart';
import 'features/task/presentation/task_home/cubit/tasks_cubit.dart';
import 'core/utils/helpers/route_helper.dart';
import 'features/auth/domain/use_cases/sign_in_usecase.dart';
import 'features/auth/domain/use_cases/sign_out.dart';
import 'features/auth/presentation/sign_in/cubit/sign_in_cubit.dart';
import 'features/auth/presentation/sign_out/cubit/sign_out_cubit.dart';
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

  // ================ Helpers ================ //

  serviceLocator.registerLazySingleton(() => InitialRouteHelper(
        launchHelper: serviceLocator<LaunchHelper>(),
        authLocalDataSource: serviceLocator<AuthenticationLocalDataSource>(),
      ));

  // ================ Data Sources ================ //
  serviceLocator.registerLazySingleton<AuthenticationRemoteDataSource>(
    () => AuthenticationRemoteDataSourceImpl(dioConsumer: serviceLocator()),
  );

  serviceLocator.registerLazySingleton<AuthenticationLocalDataSource>(
    () => AuthenticationLocalDataSourceImpl(sharedPreferences: serviceLocator()),
  );

  serviceLocator.registerLazySingleton<TasksRemoteDataSource>(
    () => TasksRemoteDataSourceImpl(dioConsumer: serviceLocator()),
  );

  // ================ Repositories ================ //
  serviceLocator.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(
      authenticationRemoteDataSource: serviceLocator(),
      networkInfo: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton<TasksRepository>(
    () => TasksRepositioryImpl(
      remoteDataSource: serviceLocator(),
      networkInfo: serviceLocator(),
    ),
  );

  // ================ Use Cases ================ //
  serviceLocator.registerLazySingleton(() => SignUpUseCase(repository: serviceLocator()));
  serviceLocator.registerLazySingleton(() => SignInUseCase(repository: serviceLocator()));
  serviceLocator.registerLazySingleton(() => SignOutUseCase(repository: serviceLocator()));
  serviceLocator.registerLazySingleton(() => CreateTaskUseCase(repository: serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetAllTastsUseCase(repository: serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetOneTaskUseCase(repository: serviceLocator()));
  serviceLocator.registerLazySingleton(() => DeleteTaskUseCase(repository: serviceLocator()));

  // ================ Blocs ================ //
  serviceLocator.registerFactory(
      () => SignUpCubit(signUpUseCase: serviceLocator(), localDataSource: serviceLocator()));
  serviceLocator.registerFactory(
      () => SignInCubit(signInUseCase: serviceLocator(), localDataSource: serviceLocator()));
  serviceLocator.registerFactory(() => SignOutCubit(
        signOutUseCase: serviceLocator(),
        localDataSource: serviceLocator(),
        remoteDataSource: serviceLocator(),
      ));

  serviceLocator.registerFactory(
    () => AddTaskCubit(useCase: serviceLocator()),
  );

  serviceLocator.registerFactory(
    () => TasksCubit(useCase: serviceLocator()),
  );

  serviceLocator.registerFactory(
    () => TaskDetailCubit(getTaskDetailUseCase: serviceLocator(), deleteUseCase: serviceLocator()),
  );
}
