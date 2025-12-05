import 'package:flutter/material.dart';
import 'package:tenseikun_apps/widgets/const_widgets_2_ticTacToe/container_widgets.dart';

class ShowDifficultiesDialog extends StatelessWidget {
  const ShowDifficultiesDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BgContainer(
      child: AlertDialog(
        backgroundColor: Colors.transparent,
        content: Column(
          children: [
            Text("data"),
          ],
        ),
      ),
    );
  }
}
