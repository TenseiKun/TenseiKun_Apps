import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:tenseikun_apps/widgets/widgets_2_ticTacToe/container_widgets.dart';

import '../../../widgets/dialog_widgets.dart';
import '../../../widgets/icon_buttons_widgets.dart';
import '../../../widgets/widgets_2_ticTacToe/btn_widgets.dart';

class TTTArena extends StatefulWidget {
  const TTTArena({super.key});

  @override
  State<TTTArena> createState() => _TTTArenaState();
}

class _TTTArenaState extends State<TTTArena> {
  String arenaText = "Round 1";
  String subArenaText = "Player 1 turn!";
  String currentPlayer = "Player 1";
  String player1Name = "Jiante Marata";
  String player2Name = "Kurosaki Ichigo";
  String winNumberP1 = "10";
  String winNumberP2 = "6";
  String winRateP1 = "100%";
  String winRateP2 = "69.42%";

  Map<int, String?> boxes = {
    00: null,
    01: null,
    02: null,
    10: null,
    11: null,
    12: null,
    20: null,
    21: null,
    22: null,
  };

  void onTap(int index) {
    if (boxes[index] != null) {
      setState(() {});
      return;
    }
    boxes[index] = currentPlayer;
    switchPlayer();
    setState(() {});
  }

  String setPlayerTag() {
    return currentPlayer;
  }

  void switchPlayer() {
    setPlayerTag();
    if (currentPlayer == "Player 1") {
      currentPlayer = "Player 2";
    } else {
      currentPlayer = "Player 1";
    }
  }

  void checkWinner() {}

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height - 100;
    double screenWidth = MediaQuery.of(context).size.height - 50;
    double panelForStatusMessage = screenHeight * 0.12;
    double panelForBoxes = screenHeight * 0.5;
    double panelForButtons = screenHeight * 0.32;
    return Scaffold(
      appBar: AppBar(
        title: Text("TenseiApps: Tic-Tac-Toe"),
        leading: BackButton(
          onPressed: () {
            showAdaptiveDialog(
              context: context,
              builder: (context) {
                return ConfirmationDialog(
                  titleText: "Are you sure you want to exit? ",
                  confirmText: "Yes",
                  cancelText: "No",
                  contents: [
                    Text(
                      "Progress will reset",
                    ),
                  ],
                );
              },
            );
          },
        ),
        actions: [
          ThemeIconButton(),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          color: Colors.green[900],
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              TTTPanelsContainer(
                height: panelForStatusMessage,
                width: screenWidth,
                child: Center(
                  child: FittedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          arenaText,
                          style: TextStyle(fontSize: 35),
                        ),
                        Text(
                          subArenaText,
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              TTTPanelsContainer(
                // color: Colors.blue,
                height: panelForBoxes,
                width: screenWidth,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TTTBoxesContainer(
                          playerTag: boxes[00],
                          panelSize: panelForBoxes,
                          onTap: () => onTap(00),
                        ),
                        TTTBoxesContainer(
                          playerTag: boxes[01],
                          panelSize: panelForBoxes,
                          onTap: () => onTap(01),
                        ),
                        TTTBoxesContainer(
                          playerTag: boxes[02],
                          panelSize: panelForBoxes,
                          onTap: () => onTap(02),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TTTBoxesContainer(
                          playerTag: boxes[10],
                          panelSize: panelForBoxes,
                          onTap: () => onTap(10),
                        ),
                        TTTBoxesContainer(
                          playerTag: boxes[11],
                          panelSize: panelForBoxes,
                          onTap: () => onTap(11),
                        ),
                        TTTBoxesContainer(
                          playerTag: boxes[12],
                          panelSize: panelForBoxes,
                          onTap: () => onTap(12),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TTTBoxesContainer(
                          playerTag: boxes[20],
                          panelSize: panelForBoxes,
                          onTap: () => onTap(20),
                        ),
                        TTTBoxesContainer(
                          playerTag: boxes[21],
                          panelSize: panelForBoxes,
                          onTap: () => onTap(21),
                        ),
                        TTTBoxesContainer(
                          playerTag: boxes[22],
                          panelSize: panelForBoxes,
                          onTap: () => onTap(22),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              TTTPanelsContainer(
                height: panelForButtons,
                width: screenWidth,
                child: Column(
                  spacing: 20,
                  children: [
                    FittedBox(
                      child: Row(
                        spacing: 10,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "PLAYER 1",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text("Username: $player1Name"),
                              Text("Wins: $winNumberP1"),
                              Text("Win rate: $winRateP1"),
                              Text("Why are we here? just to suffer")
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "PLAYER 2",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text("Username: $player2Name"),
                              Text("Wins: $winNumberP2"),
                              Text("Win rate: $winRateP2"),
                              Text("Like share and subscribe!")
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        BtnArenaBgContainer(
                          height: screenHeight * 0.12,
                          width: screenWidth * 0.2,
                          colors: [
                            Color(0xffADA996),
                            Color(0xffF2F2F2),
                            Color(0xffDBDBDB),
                            Color(0xffEAEAEA),
                          ],
                          child: TTTModeBtn(
                            icon: FontAwesomeIcons.flag,
                            iconColor: Color(0xffADA999),
                            onPressed: () {},
                            child: Text(
                              "Surrender",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 25),
                            ),
                          ),
                        ),
                        BtnArenaBgContainer(
                          height: screenHeight * 0.12,
                          width: screenWidth * 0.2,
                          colors: [
                            Color(0xffff7518),
                            Color(0xffFDEE00),
                          ],
                          child: TTTModeBtn(
                            icon: FontAwesomeIcons.computer,
                            iconColor: Color(0xffff7580),
                            onPressed: () {},
                            child: Text(
                              "Ragebait",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 25),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
