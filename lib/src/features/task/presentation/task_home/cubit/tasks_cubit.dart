import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/utils/resources/app_strings.dart';
import '../../../domain/entities/task_entity.dart';
import '../../../domain/use_cases/get_all_tasks.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  final GetAllTastsUseCase useCase;
  int currentPage = 1;
  bool isFetching = false;
  bool hasMoreTasks = true;
  String selectedCategory = AppStrings.allCategory;

  TasksCubit({required this.useCase})
      : super(const TasksInitial(selectedCategory: AppStrings.allCategory));

  Future<void> getAllTasks(
      {bool isFirstTime = false, bool isFetchingMore = false, String? category}) async {
    if (isFetching) return;
    isFetching = true;

    if (category != null) {
      selectedCategory = category;
    }

    if (isFirstTime) {
      emit(GetAllTasksLoading(selectedCategory: selectedCategory));
      currentPage = 1;
      hasMoreTasks = true;
    } else if (isFetchingMore && state is TasksWithData) {
      emit(FetchingMoreTasks((state as TasksWithData).tasks, selectedCategory: selectedCategory));
    }

    final failureOrTasks = await useCase(page: currentPage);

    failureOrTasks.fold(
      (failure) => emit(
          GetAllTasksUnSuccessfully(message: failure.message, selectedCategory: selectedCategory)),
      (tasks) {
        if (tasks.isEmpty) {
          hasMoreTasks = false;
        } else {
          currentPage++;
        }

        final filteredTasks = _filterTasksByCategory(tasks, selectedCategory);

        if (isFirstTime) {
          emit(GetAllTasksSuccessfully(
            tasks: filteredTasks,
            hasMoreTasks: hasMoreTasks,
            selectedCategory: selectedCategory,
          ));
        } else if (isFetchingMore && state is TasksWithData) {
          emit(GetAllTasksSuccessfully(
            tasks: (state as TasksWithData).tasks + filteredTasks,
            hasMoreTasks: hasMoreTasks,
            selectedCategory: selectedCategory,
          ));
        } else {
          emit(GetAllTasksSuccessfully(
            tasks: filteredTasks,
            hasMoreTasks: hasMoreTasks,
            selectedCategory: selectedCategory,
          ));
        }
      },
    );

    isFetching = false;
  }

  List<TaskEntity> _filterTasksByCategory(List<TaskEntity> tasks, String category) {
    if (category.toLowerCase() == AppStrings.allCategory.toLowerCase()) {
      return tasks;
    }
    return tasks.where((task) => task.status?.toLowerCase() == category.toLowerCase()).toList();
  }

  void selectCategory(String category) {
    getAllTasks(isFirstTime: true, category: category);
  }
}
