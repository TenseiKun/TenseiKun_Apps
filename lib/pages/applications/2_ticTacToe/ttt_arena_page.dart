import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tenseikun_apps/data/2_TicTacToe/ttt_AI.dart';

import 'package:tenseikun_apps/widgets/widgets_2_ticTacToe/container_widgets.dart';
import 'package:tenseikun_apps/widgets/widgets_2_ticTacToe/dialog_widgets.dart';

import '../../../widgets/dialog_widgets.dart';
import '../../../widgets/icon_buttons_widgets.dart';
import '../../../widgets/widgets_2_ticTacToe/btn_widgets.dart';

class TTTArena extends StatefulWidget {
  const TTTArena({super.key, required this.aiMode, required this.aiDifficulty});
  final bool aiMode;
  final String aiDifficulty;

  @override
  State<TTTArena> createState() => _TTTArenaState();
}

class _TTTArenaState extends State<TTTArena> {
  int turnCounter = 1;
  bool playerTag = true;
  late String currentPlayer;
  String player1Lbl = "Player 1";
  String player2Lbl = "Player 2";
  String player1Name = "Jiante Marata";
  String player2Name = "Kurosaki Ichigo";
  String winNumberP1 = "10";
  String winNumberP2 = "6";
  String winRateP1 = "100%";
  String winRateP2 = "69.42%";
  bool aiMode = false;

  String arenaText() {
    return "Turn $turnCounter";
  }

  String subArenaText() {
    return "${checkCurrentPlayer()}: ${playerTag ? player1Name : player2Name} acting!";
  }

  String checkCurrentPlayer() {
    return currentPlayer = playerTag ? player1Lbl : player2Lbl;
  }

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

  @override
  void initState() {
    super.initState();
    aiMode = widget.aiMode;
    if (aiMode) {
      player2Lbl = "Player AI";
      player2Name = "Bing Chilling";
    }
  }

  void onTap(int index) {
    if (boxes[index] != null) {
      setState(() {});
      return;
    }

    boxes[index] = checkCurrentPlayer();

    if (checkWinner(checkCurrentPlayer())) {
      setState(() {});
      return;
    } else if (noWinner()) {
      setState(() {});
      return;
    }
    switchPlayer();
    setState(() {});
  }

  void switchPlayer() {
    if (playerTag) {
      playerTag = false;
      if (aiMode) {
        boxes[aiActing(
          widget.aiDifficulty,
          boxes,
          player1Lbl,
          player2Lbl,
        )!] = checkCurrentPlayer();
        if (checkWinner(checkCurrentPlayer())) {
          setState(() {});
          return;
        } else if (noWinner()) {
          setState(() {});
          return;
        }
        turnCounter++;
        playerTag = true;
      }
    } else {
      playerTag = true;
      if (aiMode) {
        boxes[aiActing(
          widget.aiDifficulty,
          boxes,
          player1Lbl,
          player2Lbl,
        )!] = checkCurrentPlayer();
        if (checkWinner(checkCurrentPlayer())) {
          setState(() {});
          return;
        } else if (noWinner()) {
          setState(() {});
          return;
        }
        turnCounter++;
        playerTag = false;
      }
      turnCounter++;
    }
  }

  final List<List<int>> winPatterns = [
    //rows
    [00, 01, 02],
    [10, 11, 12],
    [20, 21, 22],
    //columns
    [00, 10, 20],
    [01, 11, 21],
    [02, 12, 22],
    //diagonals
    [00, 11, 22],
    [20, 11, 02],
  ];

  bool checkWinner(String currentPlayer) {
    for (var pattern in winPatterns) {
      int a = pattern[0];
      int b = pattern[1];
      int c = pattern[2];
      if (boxes[a] == currentPlayer &&
          boxes[b] == currentPlayer &&
          boxes[c] == currentPlayer) {
        announceWinner();
        return true;
      }
    }
    // if (boxes[00] == currentPlayer &&
    //     boxes[01] == currentPlayer &&
    //     boxes[02] == currentPlayer) {
    //   announceWinner();
    //   return true;
    // } else if (boxes[10] == currentPlayer &&
    //     boxes[11] == currentPlayer &&
    //     boxes[12] == currentPlayer) {
    //   announceWinner();
    //   return true;
    // } else if (boxes[20] == currentPlayer &&
    //     boxes[21] == currentPlayer &&
    //     boxes[22] == currentPlayer) {
    //   announceWinner();
    //   return true;
    // } else if (boxes[00] == currentPlayer &&
    //     boxes[10] == currentPlayer &&
    //     boxes[20] == currentPlayer) {
    //   announceWinner();
    //   return true;
    // } else if (boxes[01] == currentPlayer &&
    //     boxes[11] == currentPlayer &&
    //     boxes[21] == currentPlayer) {
    //   announceWinner();
    //   return true;
    // } else if (boxes[02] == currentPlayer &&
    //     boxes[12] == currentPlayer &&
    //     boxes[22] == currentPlayer) {
    //   announceWinner();
    //   return true;
    // } else if (boxes[00] == currentPlayer &&
    //     boxes[11] == currentPlayer &&
    //     boxes[22] == currentPlayer) {
    //   announceWinner();
    //   return true;
    // } else if (boxes[20] == currentPlayer &&
    //     boxes[11] == currentPlayer &&
    //     boxes[02] == currentPlayer) {
    //   announceWinner();
    //   return true;
    // }
    return false;
  }

  bool noWinner() {
    bool noWinner;
    if (boxes[00] != null &&
        boxes[01] != null &&
        boxes[02] != null &&
        boxes[10] != null &&
        boxes[11] != null &&
        boxes[12] != null &&
        boxes[20] != null &&
        boxes[21] != null &&
        boxes[22] != null) {
      noWinner = true;
      announceWinner(status: noWinner);
      return noWinner;
    } else {
      noWinner = false;
      return noWinner;
    }
  }

  void announceWinner({bool? status}) {
    showDialog(
      context: context,
      builder: (context) {
        return ShowWinnerDialog(
          winnerPlayer: status == true
              ? "No one"
              : playerTag
                  ? player1Lbl
                  : player2Lbl,
          winnerPlayerName: status == true
              ? "No one"
              : (playerTag ? player1Name : player2Name),
          turns: turnCounter,
          onPressedRestart: () {
            Navigator.pop(context);
            resetArena();
          },
          onPressedCancel: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
        );
      },
    );
  }

  void resetArena() {
    turnCounter = 1;
    playerTag = true;
    boxes.updateAll(
      (key, value) {
        return value = null;
      },
    );
    setState(() {});
  }

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
                          arenaText(),
                          style: TextStyle(fontSize: 35),
                        ),
                        Text(
                          subArenaText(),
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
                          playerLbl: boxes[00],
                          panelSize: panelForBoxes,
                          onTap: () => onTap(00),
                        ),
                        TTTBoxesContainer(
                          playerLbl: boxes[01],
                          panelSize: panelForBoxes,
                          onTap: () => onTap(01),
                        ),
                        TTTBoxesContainer(
                          playerLbl: boxes[02],
                          panelSize: panelForBoxes,
                          onTap: () => onTap(02),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TTTBoxesContainer(
                          playerLbl: boxes[10],
                          panelSize: panelForBoxes,
                          onTap: () => onTap(10),
                        ),
                        TTTBoxesContainer(
                          playerLbl: boxes[11],
                          panelSize: panelForBoxes,
                          onTap: () => onTap(11),
                        ),
                        TTTBoxesContainer(
                          playerLbl: boxes[12],
                          panelSize: panelForBoxes,
                          onTap: () => onTap(12),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TTTBoxesContainer(
                          playerLbl: boxes[20],
                          panelSize: panelForBoxes,
                          onTap: () => onTap(20),
                        ),
                        TTTBoxesContainer(
                          playerLbl: boxes[21],
                          panelSize: panelForBoxes,
                          onTap: () => onTap(21),
                        ),
                        TTTBoxesContainer(
                          playerLbl: boxes[22],
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
