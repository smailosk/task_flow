import 'package:stacked/stacked.dart';
import 'package:task_flow/app/app.locator.dart';
import 'package:task_flow/app/app.logger.dart';
import 'package:task_flow/core/error_handling/executor.dart';
import 'package:task_flow/core/models/task/task.dart';
import 'package:task_flow/services/repo_service.dart';

class SearchViewModel extends BaseViewModel {
  final _repoService = locator<RepoService>();
  final _log = getLogger('SearchViewModel');
  init() {}

  void search(String value) {
    if (value.isEmpty) {
      _searchResults.clear();
      notifyListeners();
      return;
    }
    notifyListeners();
    final input = value.trim().toLowerCase();

    final titleResults = _repoService.tasksByProject.values
        .expand((e) => e.values)
        .where((task) => task.title.toLowerCase().contains(value.toLowerCase()))
        .toList();

    final detailsResults = _repoService.tasksByProject.values
        .expand((e) => e.values)
        .where(
            (task) => task.details.toLowerCase().contains(value.toLowerCase()))
        .toList();

    final finalResults = {...titleResults, ...detailsResults}.toSet().toList();
    _searchResults.clear();
    _searchResults.addAll(finalResults);
    notifyListeners();

    _log.i('search - $input - $finalResults');
  }

  final List<TaskModel> _searchResults = [];
  List<TaskModel> get searchResults => _searchResults;

  void toggleTaskCompletion(int index, bool doneValue) {
    final task = _searchResults[index];

    Executor.runFuture(_repoService.setTaskAsDone(task, doneValue))
        .then((value) => value.fold((failure) {}, (r) {
              _searchResults[index] = task.copyWith(done: doneValue);
              notifyListeners();
              _log.i('Marked as :${!task.done}');
            }));
  }
}
