import '../../models/target.dart';

class GameState {
  static const startingTime = 15;

  final int score;
  final int timeRemaining;
  final List<Target> targets;
  final CorrectTarget? correctTarget;

  const GameState({
    this.score = 0,
    this.timeRemaining = 0,
    this.targets = const [],
    this.correctTarget,
  });

  GameState copyWith({
    int? score,
    int? timeRemaining,
    List<Target>? targets,
    CorrectTarget? correctTarget,
  }) {
    return GameState(
      score: score ?? this.score,
      timeRemaining: timeRemaining ?? this.timeRemaining,
      targets: targets ?? this.targets,
      correctTarget: correctTarget ?? this.correctTarget,
    );
  }

  bool get isRunning => timeRemaining > 0;
}

