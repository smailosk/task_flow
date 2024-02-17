import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:task_flow/core/utils/utils.dart';
import 'package:task_flow/ui/common/widgets/color_picker_item_widget.dart';

import '../../common/ui_helpers.dart';
import '../../common/widgets/main_button.dart';
import 'add_project_view.form.dart';
import 'add_project_viewmodel.dart';

@FormView(fields: [
  FormTextField(name: 'projectName'),
  FormTextField(name: 'projectColor'),
])
class AddProjectView extends StatelessWidget with $AddProjectView {
  const AddProjectView({super.key, required this.environmentId});

  final String environmentId;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddProjectViewModel>.reactive(
      viewModelBuilder: () => AddProjectViewModel(environmentId),
      onViewModelReady: (viewModel) {
        syncFormWithViewModel(viewModel);
        viewModel.init();
      },
      onDispose: (viewModel) {
        disposeForm();
      },
      builder: (context, viewModel, child) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Container(
            padding: const EdgeInsets.only(
              top: 15,
              left: 15,
              right: 15,
              bottom: 0,
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 15,
                left: 15,
                right: 15,
                bottom: 0,
              ),
              child: ListView(
                children: [
                  const Center(
                    child: Text(
                      'Create new Project',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  verticalSpaceLarge,
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Project Name',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  verticalSpaceSmall,
                  TextField(
                    controller: projectNameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                  verticalSpaceMedium,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Environment',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: viewModel.environment?.color != null
                              ? Color(int.parse(viewModel.environment!.color
                                  .replaceFirst('#', '0xff')))
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            const Icon(Icons.work),
                            horizontalSpaceSmall,
                            Text(
                              viewModel.environment?.name ?? '',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  verticalSpaceMedium,
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Project Color',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.normal),
                    ),
                  ),
                  verticalSpaceTiny,
                  SizedBox(
                    width: screenWidth(context),
                    height: 50,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: viewModel.colors.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ColorPickerItemWidget(
                              color: Utils.hexToColor(viewModel.colors[index]),
                              isSelected: viewModel.selectedColorIndex == index,
                              onTap: () => viewModel.updateSelectedColor(
                                    index,
                                  ));
                        }),
                  ),
                  verticalSpaceLarge,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MainButton(
                        enabled: true,
                        onPressed: () => viewModel.back(),
                        text: 'Cancel',
                      ),
                      MainButton(
                        enabled: viewModel.isFormValid && !viewModel.isBusy,
                        text: 'Create Project',
                        color: const Color(0xFF24A19C),
                        onPressed: viewModel.addProject,
                      ),
                    ],
                  ),
                  verticalSpaceLarge
                ],
              ),
            )),
      ),
    );
  }
}
