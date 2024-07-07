import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';
import 'package:task_flow/core/models/task/task.dart';
import 'package:task_flow/core/utils/utils.dart';
import 'package:task_flow/ui/common/ui_helpers.dart';
import 'package:task_flow/ui/common/widgets/profile_picture.dart';

import 'search_viewmodel.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SearchViewModel>.reactive(
      viewModelBuilder: () => SearchViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          title: const Center(
            child: Text(
              'Search',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 10,
            left: 20,
            right: 20,
          ),
          child: ListView(
            children: [
              TextField(
                onChanged: (value) {
                  model.search(value);
                },
                decoration: InputDecoration(
                  hintText: "Search...",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              verticalSpaceMedium,
              if (model.searchResults.isNotEmpty)
                ...List.generate(
                  model.searchResults.length,
                  (index) => SearchTaskCard(
                    task: model.searchResults[index],
                    taskIndex: index,
                  ),
                ),
              if (model.searchResults.isEmpty)
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // show image in case
                      SvgPicture.asset(
                        'assets/images/search.svg',
                        width: MediaQuery.of(context).size.width * 0.6,
                      ),
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}

class SearchTaskCard extends ViewModelWidget<SearchViewModel> {
  final TaskModel task;
  final int taskIndex;

  const SearchTaskCard({
    super.key,
    required this.task,
    required this.taskIndex,
  });

  @override
  Widget build(BuildContext context, SearchViewModel viewModel) {
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
