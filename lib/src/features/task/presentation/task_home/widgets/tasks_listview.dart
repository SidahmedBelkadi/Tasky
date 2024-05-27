import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../../../../core/api/end_points.dart';
import '../../../../../core/common/widgets/button_loader.dart';
import '../../../../../core/utils/enums/task_status_enum.dart';
import '../../../../../core/utils/helpers/toast_helper.dart';
import '../../../../../core/utils/resources/app_messages.dart';
import '../../../domain/entities/task_entity.dart';
import '../cubit/tasks_cubit.dart';

import '../../../../../config/routes/app_routes.dart';
import '../../../../../core/utils/enums/task_priority_enum.dart';

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
                                child: CircularProgressIndicator(),
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
          return Center(
            child: Text(
              AppMessages.errorDuringCommunication,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
          );
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
