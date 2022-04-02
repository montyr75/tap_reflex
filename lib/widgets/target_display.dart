import 'package:flutter/material.dart';

import '../models/target.dart';

class TargetDisplay extends StatelessWidget {
  final Target target;

  const TargetDisplay({Key? key, required this.target}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 75,
      height: 75,
      decoration: BoxDecoration(
        color: target.color.toColor(),
        shape: BoxShape.circle,
      ),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          target.number.toString(),
          style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
            color: target.textColor.toColor(),
          ),
        ),
      ),
    );
  }
}
