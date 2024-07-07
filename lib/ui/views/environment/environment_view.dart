import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:task_flow/core/utils/utils.dart';
import 'package:task_flow/ui/common/ui_helpers.dart';
import 'package:task_flow/ui/common/widgets/busy_widget.dart';

import 'environment_viewmodel.dart';

class EnvironmentView extends StatelessWidget {
  const EnvironmentView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EnvironmentViewModel>.reactive(
      viewModelBuilder: () => EnvironmentViewModel(),
      onViewModelReady: (viewModel) => viewModel.init(),
      builder: (context, viewModel, child) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        floatingActionButton: FloatingActionButton(
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xFF075B58),
          elevation: 3,
          onPressed: viewModel.navigatoToAddEnvironment,
          child: const Icon(Icons.add),
        ),
        body: BusyWidget(
          isBusy: viewModel.isBusy,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Welcome ${viewModel.displayName}',
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                Divider(color: Colors.grey.shade200),
                verticalSpace(20),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'My Environments',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                verticalSpaceMedium,
                Expanded(
                  child: GridView.builder(
                    itemCount: viewModel.environments.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
                          context,
                          value.globalPosition,
                          viewModel,
                          index,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Utils.hexToColor(
                                    viewModel.environments[index].color),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.8),
                                    spreadRadius: 1,
                                    blurRadius: 3,
                                    offset: const Offset(1, 3),
                                  ),
                                ],
                              ),
                              height: 100,
                              width: 100,
                              child: Center(
                                child: Icon(
                                  Utils.iconDataFromInt(
                                      viewModel.environments[index].icon),
                                  color: Colors.white,
                                  size: 40,
                                ),
                              ),
                            ),
                            verticalSpace(15),
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

  void _showCustomMenu(
    BuildContext context,
    Offset offset,
    EnvironmentViewModel viewModel,
    int index,
  ) {
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
          PopupMenuItem(
            child: const Row(children: [
              Icon(Icons.delete),
              SizedBox(width: 16),
              Text('Delete')
            ]),
            onTap: () {
              viewModel.deleteEnvironment(index);
            },
          )
        ],
        position: RelativeRect.fromRect(
            Rect.fromLTWH(offset.dx, offset.dy, 30, 30),
            Rect.fromLTWH(0, 0, overlay.paintBounds.size.width,
                overlay.paintBounds.size.height)));
  }
}
