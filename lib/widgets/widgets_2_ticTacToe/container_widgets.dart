import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

class DlgBgContainer extends StatelessWidget {
  const DlgBgContainer({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
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

class BtnArenaBgContainer extends StatelessWidget {
  const BtnArenaBgContainer({
    super.key,
    this.child,
    required this.height,
    required this.width,
    required this.colors,
  });

  final double height;
  final double width;
  final Widget? child;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
        gradient: LinearGradient(
          colors: colors,
        ),
      ),
      child: FittedBox(child: child),
    );
  }
}

class TTTBoxesContainer extends StatelessWidget {
  const TTTBoxesContainer(
      {super.key,
      required this.panelSize,
      required this.playerTag,
      required this.onTap});

  final String? playerTag;
  final double panelSize;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: panelSize / 3,
        width: panelSize / 3,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 2.5,
          ),
        ),
        child: Icon(
          playerTag == "Player 1"
              ? FontAwesomeIcons.circle
              : playerTag == "Player 2"
                  ? FontAwesomeIcons.x
                  : null,
          size: 80,
          color: playerTag == "Player 1" ? Colors.blue : Colors.red,
        ),
      ),
    );
  }
}

class TTTPanelsContainer extends StatelessWidget {
  const TTTPanelsContainer(
      {super.key,
      required this.height,
      required this.width,
      this.bgColor,
      this.child});

  final double height;
  final double width;
  final Color? bgColor;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 9),
      child: Container(
        height: height,
        width: width,
        color: bgColor,
        child: child,
      ),
    );
  }
}
