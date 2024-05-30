import 'package:get_it/get_it.dart';
import 'package:tasky/src/features/auth/data/data_sources/local/authentication_local_data_source.dart';
import 'package:tasky/src/features/auth/data/data_sources/remote/authentication_remote_data_source.dart';
import 'package:tasky/src/features/auth/data/repositories/authentication_repository_impl.dart';
import 'package:tasky/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:tasky/src/features/auth/domain/use_cases/sign_in_usecase.dart';
import 'package:tasky/src/features/auth/domain/use_cases/sign_out.dart';
import 'package:tasky/src/features/auth/domain/use_cases/sign_up_usecase.dart';
import 'package:tasky/src/features/auth/presentation/sign_in/cubit/sign_in_cubit.dart';
import 'package:tasky/src/features/auth/presentation/sign_out/cubit/sign_out_cubit.dart';
import 'package:tasky/src/features/auth/presentation/sign_up/cubit/sign_up_cubit.dart';

final serviceLocator = GetIt.instance;

void initAuthDependencies() {
  serviceLocator.registerLazySingleton<AuthenticationRemoteDataSource>(
    () => AuthenticationRemoteDataSourceImpl(dioConsumer: serviceLocator()),
  );

  serviceLocator.registerLazySingleton<AuthenticationLocalDataSource>(
    () => AuthenticationLocalDataSourceImpl(sharedPreferences: serviceLocator()),
  );

  serviceLocator.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(
      authenticationRemoteDataSource: serviceLocator(),
      networkInfo: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton(() => SignUpUseCase(repository: serviceLocator()));
  serviceLocator.registerLazySingleton(() => SignInUseCase(repository: serviceLocator()));
  serviceLocator.registerLazySingleton(() => SignOutUseCase(repository: serviceLocator()));

  serviceLocator.registerFactory(
      () => SignUpCubit(signUpUseCase: serviceLocator(), localDataSource: serviceLocator()));
  serviceLocator.registerFactory(
      () => SignInCubit(signInUseCase: serviceLocator(), localDataSource: serviceLocator()));
  serviceLocator.registerFactory(() => SignOutCubit(
        signOutUseCase: serviceLocator(),
        localDataSource: serviceLocator(),
        remoteDataSource: serviceLocator(),
      ));
}
