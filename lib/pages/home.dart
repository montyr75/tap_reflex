import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/game/game.dart';
import '../models/enums.dart' show TargetColorX;
import '../widgets/prompt.dart';
import '../widgets/target_display.dart';

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GameBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: BlocBuilder<GameBloc, GameState>(
                        buildWhen: (previous, current) => previous.timeRemaining != current.timeRemaining,
                        builder: (context, state) {
                          return state.isRunning ? Text(
                            "Time: ${state.timeRemaining}",
                            style: const TextStyle(fontSize: 24),
                          ) : const SizedBox.shrink();
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: BlocBuilder<GameBloc, GameState>(
                        buildWhen: (previous, current) => previous.correctTarget != current.correctTarget,
                        builder: (context, state) {
                          return state.isRunning ? Prompt(
                            text: state.correctTarget.toString(),
                            color: state.correctTarget!.color.toColor(),
                          ) : const SizedBox.shrink();
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: BlocBuilder<GameBloc, GameState>(
                        buildWhen: (previous, current) => previous.score != current.score,
                        builder: (context, state) {
                          return Text(
                            "Score: ${state.score}",
                            style: const TextStyle(fontSize: 24),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                BlocBuilder<GameBloc, GameState>(
                  buildWhen: (previous, current) => previous.targets != current.targets
                      || previous.isRunning != current.isRunning,
                  builder: (context, state) {
                    return Expanded(
                      child: Stack(
                        children: [
                          for (final target in state.targets) AnimatedAlign(
                            duration: const Duration(milliseconds: 250),
                            alignment: Alignment(
                              target.position.x,
                              target.position.y,
                            ),
                            child: GestureDetector(
                              onTapDown: (_) => state.isRunning
                                  ? context.read<GameBloc>().targetTapped(target)
                                  : null,
                              child: TargetDisplay(target: target),
                            ),
                          ),
                          if (!state.isRunning) Align(
                            alignment: const Alignment(0, -0.2),
                            child: ElevatedButton(
                              onPressed: context.read<GameBloc>().startGame,
                              child: const Text("Start", style: TextStyle(fontSize: 32)),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
