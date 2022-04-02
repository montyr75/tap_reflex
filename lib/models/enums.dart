import 'package:flutter/material.dart' show Color, Colors;

enum TargetColor {
  orange,
  green,
  yellow,
  blue,
}

extension TargetColorX on TargetColor {
  Color toColor() {
    switch (this) {
      case TargetColor.orange: return Colors.orange;
      case TargetColor.green: return Colors.green;
      case TargetColor.yellow: return Colors.yellow;
      case TargetColor.blue: return Colors.blue;
    }
  }
}