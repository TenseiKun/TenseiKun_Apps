import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tenseikun_apps/widgets/const_widgets_2_ticTacToe/btn_widgets.dart';
import 'package:tenseikun_apps/widgets/const_widgets_2_ticTacToe/container_widgets.dart';
import 'package:tenseikun_apps/widgets/const_widgets_2_ticTacToe/dialog_widgets.dart';

import '../../../widgets/icon_buttons_widgets.dart';

class TicTacToe extends StatefulWidget {
  const TicTacToe({super.key});

  @override
  State<TicTacToe> createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height - 100;
    double screenWidth = MediaQuery.of(context).size.width - 50;
    return Scaffold(
      appBar: AppBar(
        title: Text("TenseiApps"),
        actions: [
          ThemeIconButton(),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: SafeArea(
        child: BgContainer(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 20,
                children: [
                  BtnBgContainer(
                    screenHeight: screenHeight,
                    screenWidth: screenWidth,
                    firstColor: Color(0xff373b44),
                    secondColor: Color(0xff4286f4),
                    child: TicTacToeBtn(
                      icon: FontAwesomeIcons.computer,
                      iconColor: Color(0xff373b80),
                      onPressed: () {
                        showAdaptiveDialog(
                          context: context,
                          builder: (context) {
                            return ShowDifficultiesDialog();
                          },
                        );
                      },
                      child: Text(
                        "You vs. AI",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                  ),
                  BtnBgContainer(
                    screenHeight: screenHeight,
                    screenWidth: screenWidth,
                    firstColor: Color(0xffff7518),
                    secondColor: Color(0xffFDEE00),
                    child: TicTacToeBtn(
                      icon: FontAwesomeIcons.person,
                      iconColor: Color(0xffff7580),
                      onPressed: () {
                        print("hotdog");
                      },
                      child: Text(
                        "You vs Friend",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                  BtnBgContainer(
                    screenHeight: screenHeight,
                    screenWidth: screenWidth,
                    firstColor: Color(0xff3d0c02),
                    secondColor: Color(0xffb92e34),
                    child: TicTacToeBtn(
                      icon: FontAwesomeIcons.mountain,
                      iconColor: Color(0xff3d0c50),
                      onPressed: () {},
                      child: Text(
                        "Campaign",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
