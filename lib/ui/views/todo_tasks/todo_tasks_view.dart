import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../common/widgets/reusable_icon_button.dart';
import 'todo_tasks_viewmodel.dart';

class TodoTasksView extends StatelessWidget {
  const TodoTasksView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TodoTasksViewModel>.reactive(
      viewModelBuilder: () => TodoTasksViewModel(),
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
                onPressed: () {},
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
                    value: task.isCompleted,
                    onChanged: (_) => viewModel.toggleTaskCompletion(task.id),
                  ),
                  title: Text(
                    task.title,
                    style: TextStyle(
                        decoration: task.isCompleted
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
