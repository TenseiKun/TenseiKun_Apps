import 'package:flutter/material.dart';

class ContainerForCalcBtn extends StatelessWidget {
  const ContainerForCalcBtn({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width - 50;
    double screenHeight = MediaQuery.of(context).size.height - 100;
    double panelForKeys = screenHeight * 0.4;
    return SizedBox(
      height: panelForKeys * 0.25,
      width: screenWidth * 0.25,
      child: child,
    );
  }
}
