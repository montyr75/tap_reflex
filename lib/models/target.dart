import 'enums.dart' show TargetColor;

class Target {
  final int number;
  final TargetColor color;
  final TargetColor textColor;
  final Position position;

  const Target({
    required this.number,
    required this.color,
    required this.textColor,
    this.position = const Position(0, 0),
  });

  Target copyWith({
    int? number,
    TargetColor? color,
    TargetColor? textColor,
    Position? position,
  }) {
    return Target(
      number: number ?? this.number,
      color: color ?? this.color,
      textColor: textColor ?? this.textColor,
      position: position ?? this.position,
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

class Position {
  final double x;
  final double y;

  const Position(this.x, this.y);
}

enum CorrectTargetType {
  color,
  number,
}