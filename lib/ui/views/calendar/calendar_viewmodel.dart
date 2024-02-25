import 'package:stacked/stacked.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:task_flow/app/app.locator.dart';
import 'package:task_flow/app/app.logger.dart';
import 'package:task_flow/core/error_handling/executor.dart';
import 'package:task_flow/core/models/task/task.dart';
import 'package:task_flow/services/repo_service.dart';

class CalendarViewModel extends BaseViewModel {
  final _log = getLogger('CalendarViewModel');
  final _repo = locator<RepoService>();
  DateTime _selectedDate = DateTime.utc(DateTime.now().year,
      DateTime.now().month, DateTime.now().day, 0, 0, 0, 0, 0);
  DateTime get selectedDate => _selectedDate;

  CalendarFormat _calendarFormat = CalendarFormat.month;
  CalendarFormat get calendarFormat => _calendarFormat;

  final Map<DateTime, List<TaskModel>> _events = {};
  Map<DateTime, List<TaskModel>> get events => _events;

  init() async {
    // setBusy(true);
    final tasks = _repo.tasksByProject.values.expand((e) => e.values).toList();
    _log.i('init - tasks: ${tasks.length}');
    for (final task in tasks) {
      // final date = DateTime(task.deadline!.year, task.deadline!.month,
      //     task.deadline!.day, 0, 0, 0, 0, 0);
      final date = DateTime.utc(task.deadline!.year, task.deadline!.month,
          task.deadline!.day, 0, 0, 0, 0, 0);

      if (_events[date] == null) {
        _events[date] = [];
      }
      _events[date]!.add(task);
    }
    // await Future.delayed(const Duration(seconds: 1));
    // setBusy(false);
  }

  void onDaySelected(DateTime day) {
    _log.i('onDaySelected - $day');
    _selectedDate = day;
    notifyListeners();
  }

  void onFormatChanged(CalendarFormat format) {
    _log.i('onFormatChanged - $format');
    _calendarFormat = format;

    notifyListeners();
  }

  void toggleTaskCompletion(int index, bool doneValue) {
    final task = _events[_selectedDate]![index];

    Executor.runFuture(_repo.setTaskAsDone(task, doneValue))
        .then((value) => value.fold((failure) {}, (r) {
              _events[_selectedDate]![index] = task.copyWith(done: doneValue);
              notifyListeners();
              _log.i('Marked as :${!task.done}');
            }));
  }
}
