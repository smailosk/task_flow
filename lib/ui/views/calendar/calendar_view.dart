import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:task_flow/core/models/task/task.dart';
import 'package:task_flow/core/utils/utils.dart';
import 'package:task_flow/ui/common/ui_helpers.dart';
import 'package:task_flow/ui/common/widgets/profile_picture.dart';
import 'package:task_flow/ui/views/tasks/tasks_view.dart';

import 'calendar_viewmodel.dart';

class CalendarView extends StatelessWidget {
  const CalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CalendarViewModel>.reactive(
      viewModelBuilder: () => CalendarViewModel(),
      onViewModelReady: (viewModel) => viewModel.init(),
      disposeViewModel: true,
      createNewViewModelOnInsert: true,
      fireOnViewModelReadyOnce: true,
      initialiseSpecialViewModelsOnce: true,
      builder: (context, viewModel, child) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Container(
          padding: const EdgeInsets.only(left: 25.0, right: 25.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: viewModel.isBusy
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.separated(
                    itemCount:
                        (viewModel.events[viewModel.selectedDate]?.length ??
                                0) +
                            1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return TableCalendar(
                          firstDay: DateTime.utc(2010, 10, 16),
                          lastDay: DateTime.utc(2030, 3, 14),
                          focusedDay: viewModel.selectedDate,
                          calendarFormat: viewModel.calendarFormat,
                          headerVisible: true,
                          startingDayOfWeek: StartingDayOfWeek.monday,
                          weekNumbersVisible: false,
                          selectedDayPredicate: (day) {
                            return isSameDay(viewModel.selectedDate, day);
                          },
                          eventLoader: (day) {
                            return viewModel.events[day] ?? [];
                          },
                          calendarBuilders: CalendarBuilders(
                            selectedBuilder: (context, date, focusedDay) {
                              return Container(
                                margin: const EdgeInsets.all(4.0),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  date.day.toString(),
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                                ),
                              );
                            },
                          ),
                          onFormatChanged: viewModel.onFormatChanged,
                          onDaySelected: (selectedDay, focusedDay) =>
                              viewModel.onDaySelected(selectedDay),
                        );
                      }
                      final task =
                          viewModel.events[viewModel.selectedDate]![index - 1];
                      return CalendarTaskCard(
                        task: task,
                        viewModel: viewModel,
                        taskIndex: index - 1,
                      );
                    },
                    separatorBuilder: (context, index) {
                      if (index == 0) {
                        return const SizedBox(
                          height: 20,
                        );
                      } else {
                        return const SizedBox(
                          height: 10,
                        );
                      }
                    },
                  ),
          ),
        ),
      ),
    );
  }
}

class CalendarTaskCard extends StatelessWidget {
  final TaskModel task;
  final CalendarViewModel viewModel;
  final int taskIndex;

  const CalendarTaskCard({
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
                  onChanged: (value) =>
                      viewModel.toggleTaskCompletion(taskIndex, value ?? false),
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
                // PopupMenuButton(
                //   child: const Icon(
                //     Icons.more_vert,
                //     color: Colors.black,
                //   ),
                //   itemBuilder: (context) => [
                //     const PopupMenuItem(value: 'edit', child: Text('Edit')),
                //     const PopupMenuItem(value: 'delete', child: Text('Delete')),
                //   ],
                //   onSelected: (value) {
                //     if (value == 'edit') viewModel.editTask(taskIndex);
                //     if (value == 'delete') viewModel.deleteTask(taskIndex);
                //   },
                // ),
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
                    child: ProfilePicture(
                      userId: task.assignee,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
