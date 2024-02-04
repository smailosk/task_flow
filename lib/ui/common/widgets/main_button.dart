import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  const MainButton(
      {super.key,
      required this.enabled,
      this.color,
      required this.text,
      required this.onPressed});

  final bool enabled;
  final Color? color;
  final String text;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: enabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? Colors.grey.shade200,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(text,
          style: TextStyle(
            color: color != null ? Colors.white : Colors.black,
            fontWeight: color != null ? FontWeight.bold : FontWeight.normal,
          )),
    );
  }
}
