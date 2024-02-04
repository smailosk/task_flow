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
                    TextField(
                      controller: environmentNameController,
                      decoration:
                          const InputDecoration(labelText: 'Environment name'),
                    ),
                    verticalSpaceLarge,
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
                    const SizedBox(
                      height: 15,
                    ),
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
                        // ElevatedButton(
                        //   onPressed: () {},
                        //   style: ElevatedButton.styleFrom(
                        //     backgroundColor: const Color(0xFF24A19C),
                        //     shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(10),
                        //     ),
                        //   ),
                        //   child: const Text('Create Environment',
                        //       style: TextStyle(
                        //         color: Colors.white,
                        //         fontWeight: FontWeight.bold,
                        //       )),
                        // ),
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
