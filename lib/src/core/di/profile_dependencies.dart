import 'package:get_it/get_it.dart';
import 'package:tasky/src/features/profile/data/data_sources/remote/profile_remote_data_source.dart';
import 'package:tasky/src/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:tasky/src/features/profile/domain/repositories/profile_repository.dart';
import 'package:tasky/src/features/profile/domain/use_cases/profile_use_case.dart';
import 'package:tasky/src/features/profile/presentation/cubit/profile_cubit.dart';

final serviceLocator = GetIt.instance;

void initProfileDependencies() {
  serviceLocator.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(dioConsumer: serviceLocator()),
  );

  serviceLocator.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(networkInfo: serviceLocator(), remoteDataSource: serviceLocator()),
  );

  serviceLocator.registerLazySingleton(() => ProfileUseCase(repository: serviceLocator()));

  serviceLocator.registerFactory(
    () => ProfileCubit(useCase: serviceLocator()),
  );
}
