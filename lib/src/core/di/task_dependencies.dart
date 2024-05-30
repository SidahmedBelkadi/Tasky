import 'package:get_it/get_it.dart';
import 'package:tasky/src/features/task/data/data_sources/remote/tasks_remote_data_source.dart';
import 'package:tasky/src/features/task/data/repositories/tasks_repository_impl.dart';
import 'package:tasky/src/features/task/domain/repositories/tasks_repository.dart';
import 'package:tasky/src/features/task/domain/use_cases/create_task_use_case.dart';
import 'package:tasky/src/features/task/domain/use_cases/delete_task_use_case.dart';
import 'package:tasky/src/features/task/domain/use_cases/get_all_tasks.dart';
import 'package:tasky/src/features/task/domain/use_cases/get_one_task_use_case.dart';
import 'package:tasky/src/features/task/domain/use_cases/update_task_use_case.dart';
import 'package:tasky/src/features/task/presentation/add_task/cubit/add_task_cubit.dart';
import 'package:tasky/src/features/task/presentation/task_details/cubit/task_detail_cubit.dart';
import 'package:tasky/src/features/task/presentation/task_home/cubit/tasks_cubit.dart';

final serviceLocator = GetIt.instance;

void initTaskDependencies() {
  serviceLocator.registerLazySingleton<TasksRemoteDataSource>(
    () => TasksRemoteDataSourceImpl(dioConsumer: serviceLocator()),
  );

  serviceLocator.registerLazySingleton<TasksRepository>(
    () => TasksRepositioryImpl(
      remoteDataSource: serviceLocator(),
      networkInfo: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton(() => CreateTaskUseCase(repository: serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetAllTastsUseCase(repository: serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetOneTaskUseCase(repository: serviceLocator()));
  serviceLocator.registerLazySingleton(() => DeleteTaskUseCase(repository: serviceLocator()));
  serviceLocator.registerLazySingleton(() => UpdateTaskUseCase(repository: serviceLocator()));

  serviceLocator.registerFactory(
    () => AddTaskCubit(useCase: serviceLocator()),
  );

  serviceLocator.registerFactory(
    () => TasksCubit(useCase: serviceLocator()),
  );

  serviceLocator.registerFactory(
    () => TaskDetailCubit(
      getTaskDetailUseCase: serviceLocator(),
      deleteUseCase: serviceLocator(),
      updateTaskUseCase: serviceLocator(),
    ),
  );
}
