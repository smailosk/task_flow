import 'package:flutter/material.dart';

class ColorPickerItemWidget extends StatelessWidget {
  const ColorPickerItemWidget(
      {super.key,
      required this.color,
      this.isSelected = false,
      required this.onTap});

  final Color color;
  final bool isSelected;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: GestureDetector(
        onTap: onTap,
        child: Center(
          child: ClipOval(
              child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected ? Colors.black : color,
                        width: 2,
                      )),
                  child: isSelected
                      ? const Icon(
                          Icons.check,
                          color: Colors.white,
                        )
                      : null)),
        ),
      ),
    );
  }
}
