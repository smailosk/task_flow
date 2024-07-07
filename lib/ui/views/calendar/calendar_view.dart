import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:task_flow/core/models/task/task.dart';
import 'package:task_flow/core/utils/utils.dart';
import 'package:task_flow/ui/common/ui_helpers.dart';
import 'package:task_flow/ui/common/widgets/profile_picture.dart';

import '../../common/app_colors.dart';
import 'calendar_viewmodel.dart';

class CalendarView extends StatelessWidget {
  const CalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CalendarViewModel>.reactive(
      viewModelBuilder: () => CalendarViewModel(),
      onViewModelReady: (viewModel) => viewModel.init(),
      builder: (context, viewModel, child) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: viewModel.isBusy
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      const SizedBox(height: 16),
                      // Customize the appearance of TableCalendar here
                      TableCalendar(
                        firstDay: DateTime.utc(2010, 10, 16),
                        lastDay: DateTime.utc(2030, 3, 14),
                        focusedDay: viewModel.selectedDate,
                        calendarFormat: viewModel.calendarFormat,
                        headerStyle: HeaderStyle(
                          titleTextStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                          formatButtonVisible: false,
                          leftChevronIcon: Icon(
                            Icons.arrow_back_ios,
                            size: 15,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                          rightChevronIcon: Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        daysOfWeekStyle: DaysOfWeekStyle(
                          weekdayStyle: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface),
                          weekendStyle: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withOpacity(0.6)),
                        ),
                        calendarStyle: CalendarStyle(
                          outsideDaysVisible: false,
                          weekendTextStyle: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withOpacity(0.6)),
                          selectedDecoration: const BoxDecoration(
                            color: kcPrimaryColor,
                            shape: BoxShape.circle,
                          ),
                          todayDecoration: BoxDecoration(
                            border:
                                Border.all(color: kcPrimaryColor, width: 0.8),
                            shape: BoxShape.circle,
                          ),
                        ),
                        selectedDayPredicate: (day) =>
                            isSameDay(viewModel.selectedDate, day),
                        onDaySelected: (selectedDay, focusedDay) =>
                            viewModel.onDaySelected(selectedDay),
                        eventLoader: (day) => viewModel.events[day] ?? [],
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: ListView.separated(
                          itemCount: (viewModel
                                  .events[viewModel.selectedDate]?.length ??
                              0),
                          itemBuilder: (context, index) {
                            final task = viewModel
                                .events[viewModel.selectedDate]![index];
                            return CalendarTaskCard(
                                task: task,
                                viewModel: viewModel,
                                taskIndex: index);
                          },
                          separatorBuilder: (context, index) => const Divider(),
                        ),
                      ),
                    ],
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
