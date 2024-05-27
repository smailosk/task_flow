import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'test_view_viewmodel.dart';

class TestViewView extends StatelessWidget {
  const TestViewView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TestViewViewModel>.reactive(
      viewModelBuilder: () => TestViewViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Container(
          padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        ),
      ),
    );
  }
}
