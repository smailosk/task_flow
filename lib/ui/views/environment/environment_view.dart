import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'environment_viewmodel.dart';

class EnvironmentView extends StatelessWidget {
  const EnvironmentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // List<EnvData> categories = [
    //   EnvData('Home', Colors.yellow, Icons.home_outlined),
    //   EnvData('Private', Colors.greenAccent, Icons.privacy_tip_outlined),
    //   EnvData('Work 1', Colors.pink, Icons.work_outline),
    //   EnvData('Work 2', Colors.pinkAccent.shade100, Icons.work_outline),
    //   EnvData('Home 2', Colors.yellow.shade800, Icons.home_outlined),
    // ];

    return ViewModelBuilder<EnvironmentViewModel>.reactive(
      viewModelBuilder: () => EnvironmentViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Welcome Ismail ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )),
              const SizedBox(height: 10),
              Expanded(
                child: GridView.builder(
                  itemCount: model.environments.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                  itemBuilder: (context, index) {
                    return CategoryItem(
                      title: model.environments[index].title,
                      color: model.environments[index].color,
                      iconData: model.environments[index].icon,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          foregroundColor: Colors.white,
          backgroundColor: Colors.blueGrey.shade700,
          elevation: 3,
          onPressed: () => model.openBottomSheet(),
          // onPressed: () => _showAddEnvironmentBottomSheet(context, model),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void _showAddEnvironmentBottomSheet(
    BuildContext context,
    EnvironmentViewModel model,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (BuildContext bc) {
        final double bottomInset = MediaQuery.of(context).viewInsets.bottom;

        return Padding(
          padding: EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
            bottom: bottomInset,
          ),
          child: Wrap(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    const Text(
                      'Create new Environment',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    TextField(
                      decoration:
                          const InputDecoration(labelText: 'Environment name'),
                      onChanged: (value) {
                        model.newEnvironmentTitle = value;
                      },
                    ),
                    // Other input fields and options go here
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Color selection logic goes here
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade200,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text('Cancel',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                              )),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            model.addNewEnvironment();
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF24A19C),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text('Create Environment',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// class EnvData {
//   final String title;
//   final Color color;
//   final IconData icon;
//
//   EnvData(this.title, this.color, this.icon);
// }

class CategoryItem extends StatelessWidget {
  final String title;
  final Color color;
  final IconData iconData;

  const CategoryItem({
    Key? key,
    required this.title,
    required this.color,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(iconData, size: 30),
          const SizedBox(height: 10),
          Text(title),
        ],
      ),
    );
  }
}
