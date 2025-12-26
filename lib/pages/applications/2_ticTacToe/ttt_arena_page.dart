import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tenseikun_apps/data/2_TicTacToe/tic_tac_toe_ai.dart';
import 'package:tenseikun_apps/sfx/2_tic_tac_toe_sounds/tic_tac_toe_sfx.dart';

import 'package:tenseikun_apps/widgets/widgets_2_ticTacToe/container_widgets.dart';
import 'package:tenseikun_apps/widgets/widgets_2_ticTacToe/dialog_widgets.dart';

import '../../../data/2_TicTacToe/data_tictactoe.dart';
import '../../../model/2_ticTacToe_models/player_models.dart';
import '../../../widgets/dialog_widgets.dart';
import '../../../widgets/icon_buttons_widgets.dart';
import '../../../widgets/widgets_2_ticTacToe/btn_widgets.dart';

class TTTArena extends StatefulWidget {
  const TTTArena(
      {super.key,
      required this.aiMode,
      required this.aiDifficulty,
      required this.timedMode});
  final bool aiMode;
  final bool timedMode;
  final String aiDifficulty;

  @override
  State<TTTArena> createState() => _TTTArenaState();
}

class _TTTArenaState extends State<TTTArena> {
  List<Users> usersList = [];
  Users? currentP1User;
  Users? currentP2User;
  bool arenaReady = false;
  Random random = Random();
  Timer? turnTime;
  int turnCounter = 1;
  int actions = 0;
  int timer = 0;
  int maxTime = 3;
  bool playerTag = true;
  late String currentPlayer;
  String player1Lbl = "Player 1";
  String player2Lbl = "Player 2";
  String? playerAiName;
  int? playerAiWins;
  int? playerAiTotalMatch;
  double? playerAiWinRate;
  bool? noWinner;
  bool aiMode = false;
  bool disablePlayerTurn = false;
  bool timedMode = false;

  final List<String> aiRandomNames = [
    "Santiago",
    "Raiden",
    "Phainon",
    "Miko",
    "Reymark",
    "Mark",
    "Lester",
    "Cedrick",
    "Kyle",
    "Marie",
    "Justin",
    "Elysia",
    "Camelia",
    "Mika",
    "Erisa",
    "Ellen",
    "Xifu"
  ];

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

  String arenaText() {
    return "Turn $turnCounter";
  }

  String subArenaText() {
    return "${checkCurrentPlayer()}: ${playerTag ? currentP1User!.name : (aiMode ? playerAiName : currentP2User!.name)} acting!";
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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    whoGoesFirst();
  }

  @override
  void dispose() {
    super.dispose();
    if (turnTime != null) {
      turnTime!.cancel();
    }
    TTTSoundEffects.player.stop();
  }

  void whoGoesFirst() async {
    await loadUsersList();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Map result = await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return MatchUpDlg(aiMode: widget.aiMode);
        },
      );
      playerTag = result['playerTag'];
      currentP1User = result['currentP1User'];
      if (result["currentP2User"] != null) {
        currentP2User = result['currentP2User'];
      }
      readyArena();
      if (aiMode && playerTag == false) {
        switchPlayer();
      }
    });
  }

  void readyArena() {
    aiMode = widget.aiMode;
    timedMode = widget.timedMode;
    if (aiMode) {
      player2Lbl = "Player AI";
      playerAiName = aiRandomNames[random.nextInt(aiRandomNames.length)];
      playerAiTotalMatch = random.nextInt(160) + 1;
      playerAiTotalMatch = random.nextInt(160) + 20;
      playerAiWins = random.nextInt(playerAiTotalMatch!);
      playerAiWinRate = (playerAiWins! / playerAiTotalMatch!) * 100;
    }
    arenaReady = true;
    if (timedMode) {
      turnTimer();
    }
    setState(() {});
  }

  Future loadUsersList() async {
    final users = await loadTicTacToeUsers();
    setState(() {
      usersList = users;
    });
  }

  Future updateUsersList(bool player1Winner, bool noWinner, bool aiMode) async {
    await loadUsersList();
    if (!aiMode) {
      Users winnerPlayer;
      Users loserPlayer;
      if (player1Winner) {
        winnerPlayer = currentP1User!;
        loserPlayer = currentP2User!;
      } else {
        winnerPlayer = currentP2User!;
        loserPlayer = currentP1User!;
      }
      Users matchedUserWinner = usersList.firstWhere(
          (user) => user.name.toLowerCase() == winnerPlayer.name.toLowerCase());
      if (noWinner == false) {
        matchedUserWinner.wins += 1;
      }
      matchedUserWinner.totalMatch += 1;
      matchedUserWinner.winRate =
          (matchedUserWinner.wins / matchedUserWinner.totalMatch) * 100;
      Users matchedUserLoser = usersList.firstWhere(
          (user) => user.name.toLowerCase() == loserPlayer.name.toLowerCase());
      matchedUserLoser.totalMatch += 1;
      matchedUserLoser.winRate =
          (matchedUserLoser.wins / matchedUserLoser.totalMatch) * 100;
    } else {
      Users humanPlayer;
      humanPlayer = currentP1User!;
      Users matchedUserWinner = usersList.firstWhere(
          (user) => user.name.toLowerCase() == humanPlayer.name.toLowerCase());
      if (noWinner == false && player1Winner) {
        matchedUserWinner.wins += 1;
      }
      matchedUserWinner.totalMatch += 1;
      matchedUserWinner.winRate =
          (matchedUserWinner.wins / matchedUserWinner.totalMatch) * 100;
    }
    await saveTicTacToeUsers(usersList);
  }

  void onTap(int index) {
    for (var i = 0; i < usersList.length; i++) {}
    if (disablePlayerTurn) {
      return;
    }
    if (boxes[index] != null) {
      setState(() {});
      return;
    }
    TTTSoundEffects.arenaTapSound(playerTag);
    boxes[index] = checkCurrentPlayer();
    if (checkWinner(checkCurrentPlayer())) {
      setState(() {});
      return;
    } else if (noOneWins()) {
      setState(() {});
      return;
    }
    actions++;
    if (aiMode) {
      playerTag = !playerTag;
    }
    switchPlayer();
    turnManager();
    setState(() {});
  }

  void switchPlayer() async {
    if (!aiMode) {
      if (playerTag) {
        playerTag = false;
        if (timedMode) {
          turnTime!.cancel();
          turnTimer();
        }
      } else if (!playerTag) {
        playerTag = true;
        if (timedMode) {
          turnTime!.cancel();
          turnTimer();
        }
      }
    }
    if (aiMode) {
      await aiThinking();
      boxes[aiActing(widget.aiDifficulty, boxes, player1Lbl, player2Lbl)!] =
          checkCurrentPlayer();
      TTTSoundEffects.arenaTapSound(playerTag);
      if (checkWinner(checkCurrentPlayer())) {
        setState(() {});
        return;
      } else if (noOneWins()) {
        setState(() {});
        return;
      }
      actions++;
      playerTag = !playerTag;
      turnManager();
    }
  }

  void turnManager() {
    if (actions == 2) {
      turnCounter++;
      actions = 0;
    }
  }

  Future aiThinking() async {
    int seconds = random.nextInt(2) + 1;
    disablePlayerTurn = true;
    while (seconds > 0) {
      await Future.delayed(Duration(seconds: 1));
      seconds--;
      setState(() {});
    }
    disablePlayerTurn = false;
  }

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
    return false;
  }

  bool noOneWins() {
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
      return noWinner!;
    } else {
      noWinner = false;
      return noWinner!;
    }
  }

  void announceWinner({bool? status}) {
    if (timedMode) {
      turnTime!.cancel();
    }
    if (!aiMode) {
      TTTSoundEffects.arenaWinnerSound();
    }
    if (aiMode && playerTag) {
      TTTSoundEffects.arenaWinnerSound();
    }
    showDialog(
      barrierDismissible: false,
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
              : "${playerTag ? currentP1User!.name : (aiMode ? playerAiName : currentP2User!.name)}",
          turns: turnCounter,
          onPressedRestart: () async {
            Navigator.pop(context);
            TTTSoundEffects.player.stop();
            await updateUsersList(playerTag, noWinner!, aiMode);
            resetArena();
            whoGoesFirst();
          },
          onPressedCancel: () async {
            Navigator.pop(context);
            Navigator.pop(context);
            await updateUsersList(playerTag, noWinner!, aiMode);
          },
        );
      },
    );
  }

  void resetArena() {
    arenaReady = false;
    turnCounter = 1;
    actions = 0;
    playerTag = true;
    boxes.updateAll(
      (key, value) {
        return value = null;
      },
    );
    if (timedMode) {
      maxTime = 3;
      turnTimer();
    }
    setState(() {});
  }

  void turnTimer() {
    timer = maxTime;
    if (arenaReady) {
      turnTime = Timer.periodic(
        Duration(seconds: 1),
        (_) {
          if (timer > 0) {
            timer--;
            setState(() {});
          } else {
            playerTag = !playerTag;
            announceWinner(status: false);
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height - 100;
    double screenWidth = MediaQuery.of(context).size.width;
    double panelForStatusMessage = screenHeight * 0.12;
    double panelForBoxes = screenHeight * 0.5;
    double panelForButtons = screenHeight * 0.32;
    if (!arenaReady) {
      return LoadingDataWidget(
        screenHeight: screenHeight,
        screenWidth: screenWidth,
      );
    } else {
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
                          timedMode
                              ? RichText(
                                  text: TextSpan(
                                    style: TextStyle(fontSize: 15),
                                    text: "Time Remaining: ",
                                    children: [
                                      TextSpan(
                                        text: timer.toString(),
                                        style:
                                            TextStyle(color: Colors.amber[400]),
                                      ),
                                    ],
                                  ),
                                )
                              : SizedBox()
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        spacing: 10,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                player1Lbl.toUpperCase(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text("Username: ${currentP1User!.name}"),
                              Text("Wins: ${currentP1User!.wins}"),
                              Text(
                                  "Win rate: ${currentP1User!.winRate.toStringAsFixed(2)}"),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                player2Lbl.toUpperCase(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                  "Username: ${aiMode ? playerAiName! : currentP2User!.name}"),
                              Text(
                                  "Wins: ${aiMode ? playerAiWins! : currentP2User!.wins}"),
                              Text(
                                  "Win rate: ${aiMode ? playerAiWinRate!.toStringAsFixed(2) : currentP2User!.winRate.toStringAsFixed(2)}"),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          BtnArenaBgContainer(
                            height: screenHeight * 0.12,
                            width: screenWidth * 0.4,
                            colors: [
                              Color(0xffADA996),
                              Color(0xffF2F2F2),
                              Color(0xffDBDBDB),
                              Color(0xffEAEAEA),
                            ],
                            child: TTTModeBtn(
                              icon: FontAwesomeIcons.flag,
                              iconColor: Color(0xffADA999),
                              onPressed: () {
                                resetArena();
                                whoGoesFirst();
                              },
                              child: Text(
                                "Surrender",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 25),
                              ),
                            ),
                          ),
                          BtnArenaBgContainer(
                            height: screenHeight * 0.12,
                            width: screenWidth * 0.4,
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
                                style: TextStyle(
                                    color: Colors.black, fontSize: 25),
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
}

class LoadingDataWidget extends StatelessWidget {
  const LoadingDataWidget(
      {super.key, required this.screenWidth, required this.screenHeight});

  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.green[900],
          padding: EdgeInsets.all(8),
          child: Center(
            child: SizedBox(
              width: screenWidth * 0.8,
              height: screenHeight * 0.5,
              child: CircularProgressIndicator.adaptive(),
            ),
          ),
        ),
      ),
    );
  }
}
