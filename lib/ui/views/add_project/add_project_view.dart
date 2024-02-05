import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../common/ui_helpers.dart';
import '../../common/widgets/main_button.dart';
import 'add_project_viewmodel.dart';

class AddProjectView extends StatelessWidget {
  const AddProjectView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddProjectViewModel>.reactive(
      viewModelBuilder: () => AddProjectViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Container(
            padding: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  const Text(
                    'Create new Project',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  verticalSpaceLarge,
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Project Name',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.normal),
                    ),
                  ),
                  verticalSpaceSmall,
                  const TextField(
                    decoration: InputDecoration(
                      hintText: 'Project name',
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
                              fontSize: 16, fontWeight: FontWeight.normal),
                        ),
                      ),
                      Container(
                        color: Colors.red,
                        padding: const EdgeInsets.all(8),
                        child: const Row(
                          children: [
                            Icon(Icons.cabin),
                            horizontalSpaceSmall,
                            Text(
                              'Env-Name',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
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
                          fontSize: 16, fontWeight: FontWeight.normal),
                    ),
                  ),
                  verticalSpaceTiny,
                  // SizedBox(
                  //   width: screenWidth(context),
                  //   height: 50,
                  //   child: ListView.builder(
                  //       scrollDirection: Axis.horizontal,
                  //       itemCount: viewModel.colors.length,
                  //       shrinkWrap: true,
                  //       itemBuilder: (context, index) {
                  //         return ColorPickerItemWidget(
                  //             color:
                  //             Utils.hexToColor(viewModel.colors[index]),
                  //             isSelected:
                  //             viewModel.selectedColorIndex == index,
                  //             onTap: () => viewModel.updateSelectedColor(
                  //               index,
                  //             ));
                  //       }),
                  // ),
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
                        enabled: true,
                        text: 'Create Environment',
                        color: const Color(0xFF24A19C),
                        onPressed: () {},
                      ),
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }
}
