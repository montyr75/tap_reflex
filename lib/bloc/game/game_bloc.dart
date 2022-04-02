import 'dart:async';
import 'dart:math' show Random;

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart' show Alignment;

import '../../models/target.dart';
import 'game_state.dart';

class GameBloc extends Cubit<GameState> {
  static final rng = Random();

  Timer? _timer;

  GameBloc() : super(const GameState());

  void startGame() {
    emit(state.copyWith(
      score: 0,
      timeRemaining: GameState.startingTime,
    ));

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final newTime = state.timeRemaining - 1;

      emit(state.copyWith(timeRemaining: newTime));

      if (newTime <= 0) {
        _timer?.cancel();
      }
    });

    newRound();
  }

  void newRound() {
    // reposition targets.
    final targets = _repositionTargets();

    // randomly generate correct target
    emit(state.copyWith(
      targets: targets,
      correctTarget: CorrectTarget(
        type: CorrectTargetType.values[rng.nextInt(2)],
        target: targets[rng.nextInt(targets.length)],
      ),
    ));
  }

  void targetTapped(Target target) {
    if (target == state.correctTarget!.target) {
      emit(state.copyWith(score: state.score + 1));
      newRound();
    }
    else {
      emit(state.copyWith(score: state.score - 1));
    }
  }

  List<Target> _repositionTargets() {
    final List<Target> targets = [];
    final textColors = TargetColor.values.reversed.toList();

    for (int i = 0; i < TargetColor.values.length; i++) {
      targets.add(Target(
        number: i + 1,
        color: TargetColor.values[i],
        textColor: textColors[i],
        alignment: Alignment(
          rng.nextDouble() * 2 - 1,
          rng.nextDouble() * 2 - 1,
        ),
      ));
    }

    return targets;
  }
}
