import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:tasky/src/core/common/widgets/error_during_communication.dart';
import 'package:tasky/src/features/task/presentation/task_home/widgets/listview_skeleton.dart';
import 'package:tasky/src/features/task/presentation/task_home/widgets/no_more_tasks.dart';
import 'package:tasky/src/features/task/presentation/task_home/widgets/no_tasks_found.dart';
import 'package:tasky/src/features/task/presentation/task_home/widgets/task_skeleton.dart';
import '../../../../../config/routes/app_routes.dart';
import '../../../../../core/api/end_points.dart';
import '../../../../../core/utils/enums/task_priority_enum.dart';
import '../../../../../core/utils/enums/task_status_enum.dart';
import '../../../../../core/utils/helpers/toast_helper.dart';
import '../../../domain/entities/task_entity.dart';
import '../cubit/tasks_cubit.dart';
import 'task.dart';

class TasksListView extends StatelessWidget {
  const TasksListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksCubit, TasksState>(
      builder: (context, state) {
        if (state is GetAllTasksLoading) {
          return const ListviewSkeleton();
        }

        if (state is TasksWithData) {
          final tasks = state.tasks;
          if (tasks.isEmpty) {
            return const NoTasksFound();
          }

          return LayoutBuilder(
            builder: (context, constraints) {
              return NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                  if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
                      state is GetAllTasksSuccessfully &&
                      state.hasMoreTasks &&
                      constraints.maxHeight < tasks.length * 100) {
                    // Dynamic condition
                    context.read<TasksCubit>().getAllTasks(isFetchingMore: true);
                  }
                  return true;
                },
                child: RefreshIndicator(
                  onRefresh: () async {
                    await context.read<TasksCubit>().getAllTasks(isFirstTime: true);
                  },
                  child: AnimationLimiter(
                    child: ListView.builder(
                      itemCount: tasks.length + 1,
                      itemBuilder: (_, int index) {
                        if (index == tasks.length) {
                          if (state is FetchingMoreTasks) {
                            return const TaskItemSkeleton();
                          } else if (state is GetAllTasksSuccessfully && !state.hasMoreTasks) {
                            return const NoMoreTasks();
                          }
                          return const SizedBox.shrink();
                        }

                        final TaskEntity task = tasks[index];
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 500),
                          child: SlideAnimation(
                            verticalOffset: -100,
                            child: FadeInAnimation(
                              child: TaskItem(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed(Routes.taskDetails, arguments: {'id': task.id});
                                },
                                taskImage: "${EndPoints.baseUrl}/images/${task.image}",
                                isNetworkImage: true,
                                taskTitle: task.title,
                                taskDesc: task.description,
                                taskPriority: getTaskPriorityFromString(task.priority),
                                taskStatus: getTaskStatusFromString(task.status ?? "waiting"),
                                taskDate: task.formattedUpdatedAt,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          );
        }

        if (state is GetAllTasksUnSuccessfully) {
          return const ErrorDuringCommunication();
        }

        return const SizedBox();
      },
      listener: (BuildContext context, TasksState state) {
        if (state is GetAllTasksUnSuccessfully) {
          AppToasts.showErrorToast(message: state.message, context: context);
        }
      },
    );
  }
}
