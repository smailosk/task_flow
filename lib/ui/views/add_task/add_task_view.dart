import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:task_flow/core/models/task/task.dart';
import 'package:task_flow/ui/views/add_task/add_task_view.form.dart';

import '../../common/ui_helpers.dart';
import '../../common/widgets/main_button.dart';
import 'add_task_viewmodel.dart';

@FormView(fields: [
  FormTextField(name: 'taskTitle'),
  FormTextField(name: 'taskDetails'),
])
class AddTaskView extends StatelessWidget with $AddTaskView {
  const AddTaskView({super.key, required this.projectId, this.task});
  final String projectId;
  final TaskModel? task;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddTaskViewModel>.reactive(
      viewModelBuilder: () => AddTaskViewModel(projectId, task),
      onViewModelReady: (viewModel) {
        syncFormWithViewModel(viewModel);
        viewModel.init();
      },
      onDispose: (viewModel) {
        disposeForm();
      },
      builder: (context, viewModel, child) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.all(15),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Text(
                      task != null ? 'Edit Task' : 'Create new Task',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    verticalSpaceLarge,
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Task Title:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    verticalSpaceSmall,
                    TextField(
                      controller: taskTitleController,
                      decoration: const InputDecoration(
                        hintText: 'Task Title',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                    verticalSpaceMedium,
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Task Details:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.normal),
                      ),
                    ),
                    verticalSpaceSmall,
                    TextField(
                      controller: taskDetailsController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      minLines: 3,
                      decoration: InputDecoration(
                        hintText: "Enter your details here...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    verticalSpaceMedium,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Project:',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.normal),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            viewModel.project?.name ?? 'No project found',
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      ],
                    ),
                    verticalSpaceMedium,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Time:',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.normal),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: const Text(
                            '10:00',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      ],
                    ),
                    verticalSpaceMedium,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Assignee:',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.normal),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.add),
                          ),
                        )
                      ],
                    ),
                    verticalSpaceLarge,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MainButton(
                          enabled: true,
                          onPressed: viewModel.back,
                          text: 'Cancel',
                        ),
                        MainButton(
                            enabled: true,
                            text: task != null ? 'Save changes' : 'Create Task',
                            color: const Color(0xFF24A19C),
                            onPressed: () {
                              if (task != null) {
                                viewModel.updateTask(task!);
                              } else {
                                viewModel.createTask();
                              }
                            }),
                      ],
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
