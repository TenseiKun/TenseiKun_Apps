import 'package:flutter/material.dart';

class BgContainer extends StatelessWidget {
  const BgContainer({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            Color(0xffb92b27),
            Color(0xff1565C0),
          ],
        ),
      ),
      child: child,
    );
  }
}

class BtnBgContainer extends StatelessWidget {
  const BtnBgContainer(
      {super.key,
      this.child,
      required this.screenWidth,
      required this.screenHeight,
      required this.firstColor,
      required this.secondColor});

  final double screenWidth;
  final double screenHeight;
  final Widget? child;
  final Color firstColor;
  final Color secondColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenWidth * 0.3,
      width: screenHeight * 0.3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
        gradient: LinearGradient(
          colors: [firstColor, secondColor],
        ),
      ),
      child: FittedBox(child: child),
    );
  }
}
