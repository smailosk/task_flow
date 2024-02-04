import 'package:flutter/material.dart';

class ReusableIconButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;

  const ReusableIconButton({
    Key? key,
    required this.text,
    required this.icon,
    required this.onPressed,
    required this.backgroundColor,
    this.borderRadius = 10,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(icon, color: Colors.white),
      label: Text(text,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w700,
          )),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}
