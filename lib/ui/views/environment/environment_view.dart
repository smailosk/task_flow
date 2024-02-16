import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:task_flow/core/utils/utils.dart';
import 'package:task_flow/ui/common/ui_helpers.dart';
import 'environment_viewmodel.dart';

class EnvironmentView extends StatelessWidget {
  const EnvironmentView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EnvironmentViewModel>.reactive(
      viewModelBuilder: () => EnvironmentViewModel(),
      onViewModelReady: (viewModel) => viewModel.init(),
      builder: (context, viewModel, child) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        floatingActionButton: FloatingActionButton(
          foregroundColor: Colors.white,
          backgroundColor: Colors.blueGrey.shade700,
          elevation: 3,
          onPressed: viewModel.navigatoToAddEnvironment,
          child: const Icon(Icons.add),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Welcome ${viewModel.displayName}',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  )),
              const SizedBox(height: 10),
              Expanded(
                child: GridView.builder(
                  itemCount: viewModel.environments.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1,
                    mainAxisExtent: 150,
                    crossAxisCount: 3,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => viewModel.openEnvironment(index),
                      onLongPressStart: (value) => _showCustomMenu(
                          context, value.globalPosition, viewModel, index),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            color: Utils.hexToColor(
                                viewModel.environments[index].color),
                            height: 100,
                            width: 100,
                          ),
                          verticalSpace(15),
                          // Icon(Icons.home),
                          Text(
                            viewModel.environments[index].name,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: const TextStyle(
                              height: 1,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    );
                    // return CategoryItem(
                    //   title: viewModel.environments[index].name,
                    //   color: Color(
                    //       int.tryParse(viewModel.environments[index].color) ??
                    //           0xFF24A19C),
                    //   iconData: Icons.home,
                    // );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCustomMenu(BuildContext context, Offset offset,
      EnvironmentViewModel viewModel, int index) {
    final RenderObject overlay =
        Overlay.of(context).context.findRenderObject()!;

    showMenu(
        context: context,
        items: [
          PopupMenuItem(
            child: const Row(children: [
              Icon(Icons.edit),
              SizedBox(width: 16),
              Text('Edit')
            ]),
            onTap: () {
              viewModel.navigateToEditEnvironment(index);
            },
          ),
        ],
        position: RelativeRect.fromRect(
            Rect.fromLTWH(offset.dx, offset.dy, 30, 30),
            Rect.fromLTWH(0, 0, overlay.paintBounds.size.width,
                overlay.paintBounds.size.height)));
  }
}
