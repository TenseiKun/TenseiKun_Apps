import 'package:flutter/material.dart';

class TimerNWatchButtons extends StatelessWidget {
  const TimerNWatchButtons(
      {super.key, required this.text, required this.onPressed});

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: onPressed,
      child: FittedBox(
          child: Text(
        text,
        style: const TextStyle(fontSize: 16),
      )),
    );
  }
}
