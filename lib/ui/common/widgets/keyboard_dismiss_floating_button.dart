import 'package:flutter/material.dart';
import 'package:task_flow/ui/common/app_colors.dart';

class KeyboardDismissFloatingButton extends StatelessWidget {
  const KeyboardDismissFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom != 0.0
        ? FloatingActionButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(90)),
            heroTag: 'dismissKeyboard',
            tooltip: 'Close keyboard',
            backgroundColor: kcPrimaryColor,
            mini: true,
            elevation: 2,
            onPressed: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: const Icon(Icons.arrow_downward, color: Colors.white),
          )
        : Container();
  }
}
