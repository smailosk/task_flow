import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:task_flow/core/models/environment/environment.dart';
import 'package:task_flow/core/utils/utils.dart';
import 'package:task_flow/ui/common/ui_helpers.dart';
import 'package:task_flow/ui/common/widgets/color_picker_item_widget.dart';
import 'package:task_flow/ui/common/widgets/main_button.dart';
import 'package:task_flow/ui/views/add_environment/add_environment_view.form.dart';

import '../../common/widgets/icons_picker_item_widget.dart';
import 'add_environment_viewmodel.dart';

@FormView(fields: [
  FormTextField(name: 'environmentName'),
  FormTextField(name: 'environmentColor'),
  FormTextField(name: 'environmentIcon'),
])
class AddEnvironmentView extends StatelessWidget with $AddEnvironmentView {
  AddEnvironmentView({super.key, this.environmentModel});

  final EnvironmentModel? environmentModel;
  final iconsController =
      AutoScrollController(axis: Axis.horizontal, suggestedRowHeight: 50);
  final colorsController =
      AutoScrollController(axis: Axis.horizontal, suggestedRowHeight: 50);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddEnvironmentViewModel>.reactive(
      onDispose: (viewModel) {
        disposeForm();
      },
      onViewModelReady: (viewModel) {
        syncFormWithViewModel(viewModel);
        viewModel.init(iconsController, colorsController);
      },
      viewModelBuilder: () =>
          AddEnvironmentViewModel(environmentModel: environmentModel),
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: Container(
              padding: const EdgeInsets.only(
                  top: 15, left: 15, right: 15, bottom: 0),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 15, left: 15, right: 15, bottom: 0),
                child: ListView(
                  children: [
                    Center(
                      child: Text(
                        environmentModel != null
                            ? 'Edit Environment'
                            : 'Create new Environment',
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    verticalSpaceLarge,
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Environment Name',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    verticalSpaceTiny,
                    TextField(
                      controller: environmentNameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                    verticalSpaceMedium,
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Environment Icon: ',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    verticalSpaceTiny,
                    SizedBox(
                      width: screenWidth(context),
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: viewModel.icons.length,
                        controller: iconsController,
                        itemBuilder: (context, index) {
                          final iconData = viewModel.icons[index];
                          return AutoScrollTag(
                            controller: iconsController,
                            index: index,
                            key: ValueKey(index),
                            child: IconPickerItemWidget(
                              iconData: Utils.iconDataFromInt(iconData),
                              isSelected: viewModel.selectedIcon == iconData,
                              onTap: () => viewModel.setIcon(index),
                            ),
                          );
                        },
                      ),
                    ),
                    verticalSpaceMedium,
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Environment Color',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    verticalSpaceTiny,
                    SizedBox(
                      width: screenWidth(context),
                      height: 50,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: viewModel.colors.length,
                          controller: colorsController,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return AutoScrollTag(
                              controller: colorsController,
                              index: index,
                              key: ValueKey(index),
                              child: ColorPickerItemWidget(
                                  color:
                                      Utils.hexToColor(viewModel.colors[index]),
                                  isSelected:
                                      viewModel.selectedColorIndex == index,
                                  onTap: () => viewModel.updateSelectedColor(
                                        index,
                                      )),
                            );
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
                          enabled: viewModel.isFormValid,
                          onPressed: () {
                            viewModel.environmentModel != null
                                ? viewModel.editEnvironment()
                                : viewModel.addEnvironment();
                          },
                          text: environmentModel != null
                              ? 'Save changes'
                              : 'Create Environment',
                          color: const Color(0xFF24A19C),
                        ),
                      ],
                    )
                  ],
                ),
              )),
        );
      },
    );
  }
}
