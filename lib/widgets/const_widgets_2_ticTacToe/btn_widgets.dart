import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tenseikun_apps/widgets/const_widgets_2_ticTacToe/buttonStyle_widgets.dart';

class TicTacToeBtn extends StatelessWidget {
  const TicTacToeBtn(
      {super.key,
      required this.onPressed,
      required this.iconColor,
      required this.child,
      required this.icon});

  final VoidCallback? onPressed;
  final Widget child;
  final Color iconColor;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Opacity(
            opacity: 0.5,
            child: FaIcon(
              icon,
              size: 70,
              color: iconColor,
            ),
          ),
          ElevatedButton(
            style: forGradientBtnStyle(),
            onPressed: onPressed,
            child: child,
          ),
        ],
      ),
    );
  }
}
