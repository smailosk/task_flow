import 'package:flutter/material.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:task_flow/core/models/task/task.dart';
import 'package:task_flow/core/utils/utils.dart';
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
        backgroundColor: Theme.of(context).colorScheme.surface,
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
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    verticalSpaceLarge,
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Task Title:',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    verticalSpaceSmall,
                    TextField(
                      controller: taskTitleController,
                      decoration: const InputDecoration(
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
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    verticalSpaceSmall,
                    TextField(
                      controller: taskDetailsController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      minLines: 3,
                      decoration: InputDecoration(
                        // hintText: "Enter your details here...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
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
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Utils.hexToColor(viewModel.project!.color),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            viewModel.project?.name ?? 'No project found',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
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
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            DateTime? dateTime = await showOmniDateTimePicker(
                                initialDate: viewModel.deadline,
                                context: context,
                                is24HourMode: true);

                            viewModel.setDateTime(dateTime);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              Utils.formatDateTime(viewModel.deadline),
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
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
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(10),
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
                          // isBusy: viewModel.isBusy,
                          enabled: true,
                          onPressed: viewModel.back,
                          text: 'Cancel',
                        ),
                        MainButton(
                            isBusy: viewModel.isBusy,
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
