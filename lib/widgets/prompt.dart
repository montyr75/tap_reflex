import 'package:flutter/material.dart';

class Prompt extends StatelessWidget {
  static const baseStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 24,
    shadows: [
      Shadow(
        blurRadius: 4.0,
        color: Colors.black,
        offset: Offset(0.0, 2.0),
      ),
    ],
  );

  final String text;
  final Color color;

  const Prompt({Key? key, required this.text, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text("Target: ", style: baseStyle),
        AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 250),
          style: baseStyle.copyWith(color: color),
          child: Text(text),
        ),
      ],
    );
  }
}
