import 'package:flutter/material.dart';
import 'package:task_flow/ui/common/app_colors.dart';

class BusyWidget extends StatelessWidget {
  const BusyWidget({super.key, required this.isBusy, required this.child});
  final bool isBusy;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isBusy)
          Container(
            color: Colors.black.withOpacity(0.5),
            child: const Center(
              child: CircularProgressIndicator(
                color: kcPrimaryColor,
              ),
            ),
          ),
      ],
    );
    return isBusy
        ? const Center(
            child: CircularProgressIndicator(
              color: kcPrimaryColor,
            ),
          )
        : child;
  }
}
