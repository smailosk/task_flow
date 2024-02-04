import 'dart:math';

import 'package:flutter/material.dart';
import 'package:task_flow/app/app.logger.dart';

class Utils {
  static final _log = getLogger('Utils');
  static Color hexToColor(String hexString) {
    _log.i(hexString);
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static List<Color> generateRandomColors(int count) {
    Random random = Random();
    return List.generate(count, (_) {
      // Generating a random ARGB color
      return Color.fromARGB(
        255, // Alpha value
        random.nextInt(256), // Red value
        random.nextInt(256), // Green value
        random.nextInt(256), // Blue value
      );
    });
  }
}
