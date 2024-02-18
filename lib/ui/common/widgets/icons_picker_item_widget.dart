import 'package:flutter/material.dart';

class IconPickerItemWidget extends StatelessWidget {
  final IconData iconData;
  final bool isSelected;
  final Function() onTap;

  const IconPickerItemWidget({
    super.key,
    required this.iconData,
    this.isSelected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.grey.shade400 : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        padding: const EdgeInsets.all(10),
        child: Icon(
          iconData,
          color: isSelected ? Colors.black : Colors.black,
        ),
      ),
    );
  }
}
