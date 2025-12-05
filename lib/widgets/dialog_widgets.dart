import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog(
      {super.key,
      required this.titleText,
      required this.confirmText,
      required this.cancelText,
      required this.contents});

  final String titleText;
  final String confirmText;
  final String cancelText;
  final List<Widget> contents;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(titleText),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: contents,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          child: Text(confirmText),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(cancelText),
        ),
      ],
    );
  }
}
