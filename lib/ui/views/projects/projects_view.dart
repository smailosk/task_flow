import 'dart:math';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:task_flow/core/models/project/project.dart';
import 'package:task_flow/core/utils/utils.dart';
import 'package:task_flow/ui/common/widgets/busy_widget.dart';

import '../../common/widgets/reusable_icon_button.dart';
import 'projects_viewmodel.dart';

class ProjectsView extends StatelessWidget {
  const ProjectsView({super.key, required this.environmentId});

  final String environmentId;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProjectsViewModel>.reactive(
      viewModelBuilder: () => ProjectsViewModel(environmentId),
      onViewModelReady: (viewmodel) => viewmodel.init(),
      builder: (context, viewmodel, child) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: viewmodel.back,
          ),
          title: const Text('Env Name',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 20,
              )),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 4),
              child: ReusableIconButton(
                icon: Icons.add,
                text: 'Add Project',
                onPressed: viewmodel.navigateToAddProject,
                textColor: Colors.white,
                backgroundColor: const Color(0xFF24A19C),
                borderRadius: 8.0, // Set the desired border radius
              ),
            ),
          ],
        ),
        body: BusyWidget(
          isBusy: viewmodel.isBusy,
          child: Container(
            padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'In Progress',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: viewmodel.projects.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => viewmodel.navigateToTasksView(index),
                        child: ProjectCard(
                          project: viewmodel.projects[index],
                        ),
                      );
                    },
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

class ProjectCard extends ViewModelWidget<ProjectsViewModel> {
  final ProjectModel project;
  final int tasksToShow = 2;

  const ProjectCard({super.key, required this.project});

  @override
  Widget build(BuildContext context, ProjectsViewModel viewModel) {
    return Card(
      color: Colors.grey.shade50,
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Title section
            Container(
              color: Utils.hexToColor(project.color),
              padding: const EdgeInsets.all(8.0),
              child: Text(
                project.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
            // Tasks
            Padding(
              padding: viewModel.getTasksForProject(project.id).isEmpty
                  ? EdgeInsets.zero
                  : const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: viewModel
                    .getTasksForProject(project.id)
                    .map((e) => Text(e.title))
                    .toList()
                    .sublist(
                      0,
                      min(2, viewModel.getTasksForProject(project.id).length),
                    ),
              ),
            ),

            if (viewModel.getTasksForProject(project.id).length > tasksToShow)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                child: Text(
                  '...',
                  textAlign: TextAlign.start,
                ), // Indication that there are more tasks
              ),
          ],
        ),
      ),
    );
  }
}
