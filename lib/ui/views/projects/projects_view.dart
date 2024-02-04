import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../common/widgets/reusable_icon_button.dart';
import 'projects_viewmodel.dart';

class ProjectsView extends StatelessWidget {
  const ProjectsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProjectsViewModel>.reactive(
      viewModelBuilder: () => ProjectsViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              // Handle back button
            },
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
                onPressed: () {},
                textColor: Colors.white,
                backgroundColor: const Color(0xFF24A19C),
                borderRadius: 8.0, // Set the desired border radius
              ),
            ),
          ],
        ),
        body: Container(
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
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return ProjectCard(
                      project: model.getMockProjects()[index],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProjectCard extends StatelessWidget {
  final ProjectModel project;
  final int tasksToShow = 2;

  const ProjectCard({Key? key, required this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              color: project.backgroundColor,
              padding: const EdgeInsets.all(8.0),
              child: Text(
                project.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
            // Tasks
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: project.tasks
                    .take(tasksToShow) // Take only up to 'tasksToShow' tasks
                    .map((task) => Text(task))
                    .toList(),
              ),
            ),
            if (project.tasks.length > tasksToShow)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                child: Text('...'), // Indication that there are more tasks
              ),
            const Divider(color: Colors.grey, endIndent: 8, indent: 8),
            // Deadline section
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                'Deadline: ${project.deadline}',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProjectModel {
  String title;
  Color backgroundColor;
  String deadline;
  List<String> tasks;

  ProjectModel(
    this.title,
    this.backgroundColor,
    this.deadline,
    this.tasks,
  );
}
