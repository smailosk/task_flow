import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:task_flow/core/models/task/task.dart';
import 'package:task_flow/ui/common/ui_helpers.dart';
import 'package:task_flow/ui/common/widgets/busy_widget.dart';
import 'package:task_flow/ui/common/widgets/profile_picture.dart';

import '../../../core/utils/utils.dart';
import '../../common/widgets/reusable_icon_button.dart';
import 'tasks_viewmodel.dart';

class TasksView extends StatelessWidget {
  const TasksView({super.key, required this.projectId});

  final String projectId;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TasksViewModel>.reactive(
      viewModelBuilder: () => TasksViewModel(projectId),
      onViewModelReady: (viewModel) => viewModel.init(),
      builder: (context, viewModel, child) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: viewModel.back,
          ),
          title: Text(viewModel.project!.name,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 20,
              )),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 4),
              child: ReusableIconButton(
                icon: Icons.add,
                text: 'Add Task',
                onPressed: viewModel.navigateToAddTask,
                textColor: Colors.white,
                backgroundColor: const Color(0xFF24A19C),
                borderRadius: 10,
              ),
            ),
          ],
        ),
        body: BusyWidget(
          isBusy: viewModel.isBusy,
          child: Container(
            padding: const EdgeInsets.all(25),
            child: ListView.builder(
              itemCount: viewModel.tasks.length,
              itemBuilder: (context, index) {
                final task = viewModel.tasks[index];
                return TaskCard(
                  task: task,
                  viewModel: viewModel,
                  taskIndex: index,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  final TaskModel task;
  final TasksViewModel viewModel;
  final int taskIndex;

  const TaskCard({
    super.key,
    required this.task,
    required this.viewModel,
    required this.taskIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Checkbox(
                  value: task.done,
                  onChanged: (value) => viewModel.toggleTaskCompletion(
                    taskIndex,
                    value ?? false,
                  ),
                ),
                Expanded(
                  child: Text(
                    task.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      decoration: task.done ? TextDecoration.lineThrough : null,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                PopupMenuButton(
                  child: const Icon(
                    Icons.more_vert,
                    color: Colors.black,
                  ),
                  itemBuilder: (context) => [
                    const PopupMenuItem(value: 'edit', child: Text('Edit')),
                    const PopupMenuItem(value: 'delete', child: Text('Delete')),
                  ],
                  onSelected: (value) {
                    if (value == 'edit') viewModel.editTask(taskIndex);
                    if (value == 'delete') viewModel.deleteTask(taskIndex);
                  },
                ),
              ],
            ),
            if (task.details.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 15,
                ),
                child: Text(
                  task.details,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    decoration: task.done ? TextDecoration.lineThrough : null,
                  ),
                ),
              ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 20),
                    horizontalSpaceTiny,
                    Text(
                      Utils.formatDateTime(task.deadline!),
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                if (task.assignee.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ProfilePicture(userId: task.assignee),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
