import 'package:flutter/material.dart' show Color, Colors, Alignment;

class Target {
  final int number;
  final TargetColor color;
  final TargetColor textColor;
  final Alignment alignment;

  const Target({
    required this.number,
    required this.color,
    required this.textColor,
    this.alignment = const Alignment(0, 0),
  });

  Target copyWith({
    int? number,
    TargetColor? color,
    TargetColor? textColor,
    Alignment? alignment,
  }) {
    return Target(
      number: number ?? this.number,
      color: color ?? this.color,
      textColor: textColor ?? this.textColor,
      alignment: alignment ?? this.alignment,
    );
  }
}

class CorrectTarget {
  final CorrectTargetType type;
  final Target target;

  const CorrectTarget({required this.type, required this.target});

  @override
  String toString() => type == CorrectTargetType.color
      ? target.color.name
      : target.number.toString();

  TargetColor get color => type == CorrectTargetType.color
      ? target.textColor
      : target.color;
}

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

enum CorrectTargetType {
  color,
  number,
}