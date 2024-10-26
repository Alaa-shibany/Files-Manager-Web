
import 'package:flutter/material.dart';

Color darkenColor(Color color, [double amount = 0.1]) {
  // Convert the color to HSL to manipulate the lightness
  final hsl = HSLColor.fromColor(color);

  // Decrease the lightness by a certain amount (defaults to 10% darker)
  final hslDarker = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

  // Convert it back to a Color
  return hslDarker.toColor();
}
