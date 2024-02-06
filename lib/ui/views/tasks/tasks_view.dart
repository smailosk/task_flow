import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../common/widgets/reusable_icon_button.dart';
import 'tasks_viewmodel.dart';

class TasksView extends StatelessWidget {
  const TasksView({super.key, required this.projectId});

  final String projectId;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TasksViewModel>.reactive(
      viewModelBuilder: () => TasksViewModel(projectId),
      builder: (context, viewModel, child) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: viewModel.back,
          ),
          title: const Text('Project Name',
              style: TextStyle(
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
        body: Container(
          padding: const EdgeInsets.all(25),
          child: ListView.builder(
            itemCount: viewModel.tasks.length,
            itemBuilder: (context, index) {
              final task = viewModel.tasks[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  leading: Checkbox(
                    value: task.done,
                    onChanged: (value) {
                      if (value == null) return;
                      viewModel.toggleTaskCompletion(index, value);
                    },
                  ),
                  title: Text(
                    task.title,
                    style: TextStyle(
                        decoration: task.done
                            ? TextDecoration.lineThrough
                            : TextDecoration.none),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
