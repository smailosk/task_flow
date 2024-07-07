import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  const MainButton(
      {super.key,
      required this.enabled,
      this.color,
      this.isBusy = false,
      required this.text,
      required this.onPressed});

  final bool enabled;
  final Color? color;
  final String text;
  final Function() onPressed;
  final bool isBusy;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (enabled && !isBusy) ? onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? Colors.grey.shade200,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: isBusy
          ? const Center(
              child: Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ))
          : Text(text,
              style: TextStyle(
                color: color != null ? Colors.white : Colors.black,
                fontWeight: color != null ? FontWeight.bold : FontWeight.normal,
              )),
    );
  }
}
