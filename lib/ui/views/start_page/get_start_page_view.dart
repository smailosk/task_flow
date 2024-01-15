import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'get_start_page_viewmodel.dart';

class GetStartPageView extends StackedView<GetStartPageViewModel> {
  const GetStartPageView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    GetStartPageViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 33, vertical: 91),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/images/start_image.png',
            ),
            const Text(
              "TASK-FLOW",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const Text(
              "Simplify your life by easily prioritizing and "
              "managing your daily tasks. Focus on what "
              "truly matters and let us take care of the rest!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF24A19C),
                minimumSize: const Size(double.infinity, 52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "Get Started",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  GetStartPageViewModel viewModelBuilder(BuildContext context) =>
      GetStartPageViewModel();
}
