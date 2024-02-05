import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:task_flow/core/utils/utils.dart';
import 'package:task_flow/ui/common/ui_helpers.dart';
import 'package:task_flow/ui/common/widgets/color_picker_item_widget.dart';
import 'package:task_flow/ui/common/widgets/main_button.dart';
import 'package:task_flow/ui/views/add_environment/add_environment_view.form.dart';

import 'add_environment_viewmodel.dart';

@FormView(fields: [
  FormTextField(name: 'environmentName'),
  FormTextField(name: 'environmentColor'),
  FormTextField(name: 'environmentIcon'),
])
class AddEnvironmentView extends StatelessWidget with $AddEnvironmentView {
  const AddEnvironmentView({super.key});

  // void _pickIcon(
  //     BuildContext context, AddEnvironmentViewModel viewModel) async {
  //   IconData? icon = await FlutterIconPicker.showIconPicker(context,
  //       iconPackModes: [IconPack.material]);
  //
  //   if (icon != null) {
  //     viewModel
  //         .setIcon(icon); // You need to implement setIcon in your ViewModel
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddEnvironmentViewModel>.reactive(
      onDispose: (viewModel) {
        disposeForm();
      },
      onViewModelReady: (viewModel) {
        syncFormWithViewModel(viewModel);
        viewModel.init();
      },
      viewModelBuilder: () => AddEnvironmentViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: Container(
              padding: const EdgeInsets.all(15),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    const Text(
                      'Create new Environment',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    verticalSpaceLarge,
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Environment Name',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.normal),
                      ),
                    ),
                    verticalSpaceTiny,
                    TextField(
                      controller: environmentNameController,
                      decoration: const InputDecoration(
                          labelText: 'Environment Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          fillColor: Colors.purpleAccent),
                    ),
                    verticalSpaceMedium,
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Environment Icon: '
                        '=> ToDo (add Icon Picker)',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.normal),
                      ),
                    ),
                    // Column(
                    //   children: [
                    //     IconButton(
                    //       icon: Icon(Icons.palette), // Use an icon that suggests picking an icon
                    //       onPressed: () => viewModel.selectedIcon,
                    //     ),
                    //     SizedBox(width: 10), // Spacing between button and displayed icon
                    //     Icon(viewModel.selectedIcon ?? Icons.help_outline, size: 24), // Display the selected icon or a placeholder
                    //   ],
                    // ),
                    verticalSpaceMedium,
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Environment Color',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.normal),
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
                                color:
                                    Utils.hexToColor(viewModel.colors[index]),
                                isSelected:
                                    viewModel.selectedColorIndex == index,
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
                          enabled: viewModel.isFormValid,
                          onPressed: () => viewModel.addEnvironment(),
                          text: 'Create Environment',
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
