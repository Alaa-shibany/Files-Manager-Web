import 'package:flutter/material.dart';
import 'package:files_manager/theme/color.dart';

String colorToHex(Color color) {
  // Convert the color to a hexadecimal string
  String hex = '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
  return hex;
}

bool isNearWhite(String hexColor) {
  final color = Color(int.parse(hexColor.replaceFirst('#', '0xff')));
  final brightness =
      (color.red * 0.299 + color.green * 0.587 + color.blue * 0.114);
  const double whiteThreshold = 200.0;
  return brightness > whiteThreshold;
}

Color hexToColor(String hex) {
  hex = hex.replaceAll('#', '');
  if (hex.length == 6) {
    hex = 'FF$hex'; // Add alpha value if it's not included
  }
  return Color(int.parse(hex, radix: 16));
}

List<Map<String, Color>> allColors = [
  {
    'show': Colors.black,
    'real': AppColors.dark,
  },
  {
    'show': Colors.white,
    'real': const Color.fromARGB(255, 72, 73, 74),
  },
  {
    'show': Colors.blue,
    'real': Colors.blue,
  },
  {
    'show': Colors.green,
    'real': Colors.green,
  },
  {
    'show': Colors.red,
    'real': const Color.fromARGB(255, 234, 99, 90),
  },
  {
    'show': Colors.orange,
    'real': Colors.orange,
  },
  {
    'show': Colors.black,
    'real': const Color.fromARGB(255, 27, 27, 27),
  },
];
