import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tenseikun_apps/widgets/widgets_2_ticTacToe/btn_style_widgets.dart';

class TTTModeBtn extends StatelessWidget {
  const TTTModeBtn(
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

class SelectBtn extends StatelessWidget {
  const SelectBtn(
      {super.key,
      required this.onPressed,
      required this.child,
      required this.btnColor});

  final VoidCallback? onPressed;
  final Widget child;
  final Color btnColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20, left: 20, bottom: 10, top: 10),
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        style: forSelectBtnStyle(btnColor),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
