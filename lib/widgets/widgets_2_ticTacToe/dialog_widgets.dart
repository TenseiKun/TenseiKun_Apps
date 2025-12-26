import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tenseikun_apps/model/2_ticTacToe_models/player_models.dart';
import 'package:tenseikun_apps/widgets/widgets_2_ticTacToe/btn_widgets.dart';
import 'package:tenseikun_apps/widgets/widgets_2_ticTacToe/container_widgets.dart';

import '../../data/2_TicTacToe/data_tictactoe.dart';

class ShowDifficultiesDialog extends StatelessWidget {
  const ShowDifficultiesDialog({
    super.key,
    required this.diffPage1,
    required this.diffPage2,
    required this.diffPage3,
    required this.diffPage4,
  });

  final Widget diffPage1;
  final Widget diffPage2;
  final Widget diffPage3;
  final Widget diffPage4;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.all(0),
      titlePadding: EdgeInsets.all(10),
      title: Text(
        "Choose Difficulty",
        textAlign: TextAlign.center,
      ),
      content: DlgBgContainer(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SelectBtn(
                btnColor: Colors.green,
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return diffPage1;
                      },
                    ),
                  );
                },
                child: Text(
                  "Beginner",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
              SelectBtn(
                btnColor: Colors.yellow,
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return diffPage2;
                      },
                    ),
                  );
                },
                child: Text(
                  "Amateur",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
              SelectBtn(
                btnColor: Colors.red,
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return diffPage3;
                      },
                    ),
                  );
                },
                child: Text(
                  "Master",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
              SelectBtn(
                btnColor: Colors.purple,
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return diffPage4;
                      },
                    ),
                  );
                },
                child: Text(
                  "Insanity (Unbeatable)",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShowPlayerModeDialog extends StatelessWidget {
  const ShowPlayerModeDialog({
    super.key,
    required this.playerModePage1,
    required this.playerModePage2,
  });

  final Widget playerModePage1;
  final Widget playerModePage2;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.all(0),
      titlePadding: EdgeInsets.all(10),
      title: Text(
        "Choose Mode",
        textAlign: TextAlign.center,
      ),
      content: DlgBgContainer(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SelectBtn(
                btnColor: Colors.green,
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return playerModePage1;
                      },
                    ),
                  );
                },
                child: Text(
                  "Casual Mode",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
              SelectBtn(
                btnColor: Colors.red,
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return playerModePage2;
                      },
                    ),
                  );
                },
                child: Text(
                  "Timed Mode",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class ShowCampaignDialog extends StatelessWidget {
//   const ShowCampaignDialog({
//     super.key,
//     required this.restartPage,
//     required this.lastProgressPage,
//   });
//   final Widget restartPage;
//   final Widget lastProgressPage;
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       backgroundColor: Colors.transparent,
//       contentPadding: EdgeInsets.all(0),
//       titlePadding: EdgeInsets.all(10),
//       title: Text(
//         "Choose Difficulty",
//         textAlign: TextAlign.center,
//       ),
//       content: DlgBgContainer(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               SelectBtn(
//                 btnColor: Colors.green,
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) {
//                         return restartPage;
//                       },
//                     ),
//                   );
//                 },
//                 child: Text(
//                   "Start Campaign",
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold, color: Colors.black),
//                 ),
//               ),
//               SelectBtn(
//                 btnColor: Colors.yellow,
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) {
//                         return lastProgressPage;
//                       },
//                     ),
//                   );
//                 },
//                 child: Text(
//                   "Continue Last Progress",
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold, color: Colors.black),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class ShowWinnerDialog extends StatelessWidget {
  const ShowWinnerDialog(
      {super.key,
      required this.winnerPlayer,
      required this.winnerPlayerName,
      required this.turns,
      required this.onPressedRestart,
      required this.onPressedCancel});

  final String winnerPlayer;
  final String winnerPlayerName;
  final int turns;
  final VoidCallback? onPressedRestart;
  final VoidCallback? onPressedCancel;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.all(0),
        titlePadding: EdgeInsets.all(10),
        title: Text(
          "$winnerPlayer won!",
          textAlign: TextAlign.center,
        ),
        content: DlgBgContainer(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 10,
              children: [
                Text(
                  "The battle took $turns turns.\n$winnerPlayerName won the game!",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SelectBtnFromWinnerDlg(
                        btnColor: Colors.yellow,
                        onPressed: onPressedRestart,
                        child: FittedBox(
                          child: Text(
                            "One more Round!",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                      ),
                      SelectBtnFromWinnerDlg(
                        btnColor: Colors.green,
                        onPressed: onPressedCancel,
                        child: Text(
                          "Exit",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MatchUpDlg extends StatefulWidget {
  const MatchUpDlg({
    super.key,
    required this.aiMode,
  });
  final bool aiMode;
  @override
  State<MatchUpDlg> createState() => _FirstTurnDlgState();
}

class _FirstTurnDlgState extends State<MatchUpDlg> {
  List<Users> usersList = [];
  Users? currentP1User;
  Users? currentP2User;
  Random random = Random();
  Timer? timer;
  double opacityLevel = 0;
  String playerOption = "rock";
  String player1Hand = "";
  String player2Hand = "";
  bool player1Choosing = true;
  bool? player1Winner;
  bool matchUpTime = false;
  bool? playerTag;
  bool? firstOrSecond = true;
  TextEditingController p1NameController = TextEditingController();
  TextEditingController p2NameController = TextEditingController();
  List<Hands> hands = [
    Hands(
        playHandTitle: "Rock",
        imageAsset: "assets/images/rock.png",
        playHand: "rock"),
    Hands(
        playHandTitle: "Paper",
        imageAsset: "assets/images/paper.png",
        playHand: "paper"),
    Hands(
        playHandTitle: "Scissor",
        imageAsset: "assets/images/scissor.png",
        playHand: "scissor")
  ];

  void showHand() async {
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        opacityLevel = 1.0;
      });
    });
  }

  void decidingWinnerHand(String p1Hand, String p2Hand) async {
    double seconds = 1.5;
    timer = Timer.periodic(
      Duration(seconds: 1),
      (_) {
        if (seconds > 0) {
          seconds--;
        } else {
          timer!.cancel();
          if ((p1Hand == "rock" && p2Hand == "scissor") ||
              (p1Hand == "scissor" && p2Hand == "paper") ||
              (p1Hand == "paper" && p2Hand == "rock")) {
            player1Winner = true;
          } else if ((p2Hand == "rock" && p1Hand == "scissor") ||
              (p2Hand == "scissor" && p1Hand == "paper") ||
              (p2Hand == "paper" && p1Hand == "rock")) {
            player1Winner = false;
            if (widget.aiMode) {
              double aiProbability = random.nextDouble();
              if (aiProbability < 0.3) {
                playerTag = true;
              } else {
                playerTag = false;
              }
              Navigator.pop(context, {
                "playerTag": playerTag,
                "currentP1User": currentP1User,
              });
            }
          } else {
            showDialog(
              context: context,
              builder: (context) {
                return SimpleDlg(
                  titleText: "Draw!",
                  titleTextSize: 40,
                  contents: [
                    Text(
                      "Choose hands again!",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      "tap anywhere to close",
                      style:
                          TextStyle(fontSize: 8, fontStyle: FontStyle.italic),
                    ),
                  ],
                );
              },
            );
            matchUpTime = false;
            playerOption = "rock";
            player1Hand = "";
            player2Hand = "";
            player1Choosing = true;
            opacityLevel = 0;
            timer = null;
          }
        }
        setState(() {});
      },
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await loadUsersList();
      await loadRecentUser(player1Choosing);
    });
  }

  Future loadUsersList() async {
    final users = await loadTicTacToeUsers();
    setState(() {
      usersList = users;
    });
  }

  Future saveUsersList(Users newUser) async {
    setState(() {
      usersList.add(newUser);
    });
    await saveTicTacToeUsers(usersList);
  }

  Future matchUser(String name) async {
    try {
      Users matchedUser = usersList.firstWhere(
          (user) => user.name.toLowerCase() == name.toString().toLowerCase());
      if (player1Choosing) {
        currentP1User = matchedUser;
      } else {
        currentP2User = matchedUser;
      }
    } catch (e) {
      Users newUser = Users(
        name: name,
        wins: 0,
        totalMatch: 0,
        winRate: 100,
      );
      await saveUsersList(newUser);
      if (player1Choosing) {
        currentP1User = newUser;
      } else {
        currentP2User = newUser;
      }
    }
  }

  Future loadRecentUser(bool player1Choosing) async {
    if (player1Choosing) {
      p1NameController.text = await loadRecentTicTacToeUser(player1Choosing);
    } else {
      p2NameController.text = await loadRecentTicTacToeUser(player1Choosing);
    }
    setState(() {});
  }

  Future saveRecentUser(bool player1Choosing, String recentUser) async {
    await saveRecentTicTacToeUser(player1Choosing, recentUser);
  }

  String aiHands() {
    double aiProbability = random.nextDouble();
    if (aiProbability < 0.4) {
      return "paper";
    } else if (aiProbability < 0.7 && aiProbability >= 0.41) {
      return "rock";
    } else {
      return "scissor";
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height - 100;
    double screenWidth = MediaQuery.of(context).size.width;
    return PopScope(
      canPop: false,
      child: Center(
        child: SingleChildScrollView(
          child: AlertDialog(
            backgroundColor: Colors.transparent,
            contentPadding: EdgeInsets.all(0),
            titlePadding: EdgeInsets.all(10),
            title: FittedBox(
              child: Text(
                timer == null
                    ? "${player1Choosing ? "Player 1" : "Player 2"}: Choose your hand"
                    : "Choose who goes first",
                textAlign: TextAlign.center,
              ),
            ),
            content: DlgBgContainer(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 10,
                  children: [
                    if (matchUpTime == false) ...[
                      Text(
                        "Win to get the privilege of going first or second.",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                      ),
                      ...List.generate(
                        hands.length,
                        (index) {
                          return ListTile(
                            leading: Image.asset(
                              hands[index].imageAsset,
                            ),
                            title: Text(hands[index].playHandTitle),
                            trailing: Radio.adaptive(
                              value: hands[index].playHand,
                              groupValue: playerOption,
                              onChanged: (String? value) {
                                setState(() {
                                  playerOption = value!;
                                });
                              },
                            ),
                          );
                        },
                      ),
                      Text(
                        "*Hide your playing hand from your opponent*",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10, fontStyle: FontStyle.italic),
                      ),
                      TextField(
                        maxLength: 10,
                        buildCounter: (context,
                                {required currentLength,
                                required isFocused,
                                required maxLength}) =>
                            null,
                        keyboardType: TextInputType.name,
                        controller: player1Choosing
                            ? p1NameController
                            : p2NameController,
                        decoration: InputDecoration(
                          hintText: "What's your player name?",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      SelectBtn(
                        btnColor: Colors.green,
                        onPressed: () async {
                          if (player1Choosing &&
                              p1NameController.text.isEmpty) {
                            return;
                          }
                          if (!player1Choosing &&
                              p2NameController.text.isEmpty) {
                            return;
                          }
                          if (p1NameController.text.trim() ==
                              p2NameController.text.trim()) {
                            return;
                          }
                          await matchUser(player1Choosing
                              ? p1NameController.text
                              : p2NameController.text);
                          await saveRecentUser(
                              player1Choosing, p1NameController.text);
                          if (player1Choosing) {
                            setState(() {
                              player1Hand = playerOption;
                              player1Choosing = false;
                              playerOption = "rock";
                            });
                            await loadRecentUser(player1Choosing);
                            if (widget.aiMode) {
                              setState(() {
                                player2Hand = aiHands();
                                matchUpTime = true;
                              });
                              showHand();
                              decidingWinnerHand(player1Hand, player2Hand);
                            }
                          } else {
                            await saveRecentUser(
                                player1Choosing, p2NameController.text);
                            setState(() {
                              player2Hand = playerOption;
                              matchUpTime = true;
                            });
                            showHand();
                            decidingWinnerHand(player1Hand, player2Hand);
                          }
                        },
                        child: Text(
                          "Choose ${playerOption == "rock" ? "Rock" : playerOption == "paper" ? "Paper" : "Scissor"}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                    ] else ...[
                      Text(
                        "Deciding the winner",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                      ),
                      Row(
                        spacing: 4,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedOpacity(
                            opacity: opacityLevel,
                            duration: Duration(seconds: 2),
                            curve: Curves.linear,
                            child: Image.asset(
                              height: screenHeight * 0.4,
                              width: screenWidth * 0.3,
                              (player1Hand == "rock"
                                  ? hands[0].imageAsset
                                  : player1Hand == "paper"
                                      ? hands[1].imageAsset
                                      : hands[2].imageAsset),
                            ),
                          ),
                          AnimatedOpacity(
                            opacity: opacityLevel,
                            duration: Duration(seconds: 2),
                            curve: Curves.linear,
                            child: Image.asset(
                              height: screenHeight * 0.4,
                              width: screenWidth * 0.3,
                              (player2Hand == "rock"
                                  ? hands[0].imageAsset
                                  : player2Hand == "paper"
                                      ? hands[1].imageAsset
                                      : hands[2].imageAsset),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "Player that will decide is... ${player1Winner == null ? " " : player1Winner == true ? "Player 1!" : "Player 2!"}",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 18,
                          ),
                          Radio(
                            value: player1Winner == true,
                            groupValue: firstOrSecond,
                            onChanged: (value) {
                              if (player1Winner != null) {
                                setState(() {
                                  firstOrSecond = value;
                                });
                              }
                            },
                          ),
                          Text(
                            "I go first!",
                            style: TextStyle(fontSize: 13),
                          ),
                          Radio(
                            value: player1Winner == false,
                            groupValue: firstOrSecond,
                            onChanged: (value) {
                              if (player1Winner != null) {
                                setState(() {
                                  firstOrSecond = value;
                                });
                              }
                            },
                          ),
                          Text(
                            "You go first!",
                            style: TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                      SelectBtn(
                        btnColor: Colors.green,
                        onPressed: () {
                          if (player1Winner != null) {
                            playerTag = firstOrSecond;
                            Navigator.pop(context, {
                              "playerTag": playerTag,
                              "currentP1User": currentP1User,
                              "currentP2User": currentP2User
                            });
                          }
                        },
                        child: Text(
                          "Start Game",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                    ]
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SimpleDlg extends StatelessWidget {
  const SimpleDlg({
    super.key,
    required this.titleText,
    required this.titleTextSize,
    this.contents,
  });
  final String titleText;
  final List<Widget>? contents;
  final double titleTextSize;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.all(0),
      titlePadding: EdgeInsets.all(10),
      title: Text(
        titleText,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: titleTextSize),
      ),
      content: DlgBgContainer(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 10,
              children: contents == null ? [SizedBox()] : contents!),
        ),
      ),
    );
  }
}
