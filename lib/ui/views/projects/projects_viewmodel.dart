import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:task_flow/ui/views/projects/projects_view.dart';

class ProjectsViewModel extends BaseViewModel {
  List<ProjectModel> getMockProjects() {
    return [
      ProjectModel(
        'Project Alpha',
        Colors.blue.shade700,
        '31.12.2023',
        ['Design phase', 'Development phase'],
      ),
      ProjectModel(
        'Project Beta',
        Colors.green,
        '15.01.2024',
        ['Research', 'Implementation', 'Testing'],
      ),
      ProjectModel(
        'Project Gamma',
        Colors.red,
        '30.03.2024',
        ['Planning', 'Execution'],
      ),
    ];
  }
}
