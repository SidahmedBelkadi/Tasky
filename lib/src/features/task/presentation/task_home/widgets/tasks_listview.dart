import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:todo_app/src/core/api/end_points.dart';
import 'package:todo_app/src/core/common/widgets/button_loader.dart';
import 'package:todo_app/src/core/utils/enums/task_status_enum.dart';
import 'package:todo_app/src/core/utils/resources/app_messages.dart';
import 'package:todo_app/src/features/task/domain/entities/task_entity.dart';
import 'package:todo_app/src/features/task/presentation/task_home/cubit/tasks_cubit.dart';

import '../../../../../config/routes/app_routes.dart';
import '../../../../../core/utils/enums/task_priority_enum.dart';

import 'task.dart';

class TasksListView extends StatelessWidget {
  const TasksListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksCubit, TasksState>(
      builder: (context, state) {
        if (state is GetAllTasksLoading) {
          return const Center(
            child: ButtonCircularProgressIndicator(
              height: 34,
              width: 34,
            ),
          );
        }

        if (state is TasksWithData) {
          final tasks = state.tasks;

          // Display message if no tasks found for the selected category
          if (tasks.isEmpty) {
            return Center(
              child: Text(
                'No tasks found.',
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
            );
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
                            return const Center(
                              child: Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Text("Getting more old Tasks ..."),
                              ),
                            );
                          } else if (state is GetAllTasksSuccessfully && !state.hasMoreTasks) {
                            return const Center(
                              child: Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Text("No more tasks."),
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        }

                        final TaskEntity task = tasks[index];
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 500),
                          child: SlideAnimation(
                            verticalOffset: -200,
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
          return Center(
            child: Text(
              AppMessages.errorDuringCommunication,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}
