import 'package:flutter/material.dart';
import 'package:tenseikun_apps/widgets/widgets_2_ticTacToe/btn_widgets.dart';
import 'package:tenseikun_apps/widgets/widgets_2_ticTacToe/container_widgets.dart';

class ShowDifficultiesDialog extends StatelessWidget {
  const ShowDifficultiesDialog({
    super.key,
    required this.diffPage1,
    required this.diffPage2,
    required this.diffPage3,
  });

  final Widget diffPage1;
  final Widget diffPage2;
  final Widget diffPage3;

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
                  "Normal",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
              SelectBtn(
                btnColor: Colors.yellow,
                onPressed: () {
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
                  "Insanity",
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

class ShowCampaignDialog extends StatelessWidget {
  const ShowCampaignDialog({
    super.key,
    required this.restartPage,
    required this.lastProgressPage,
  });

  final Widget restartPage;
  final Widget lastProgressPage;

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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return restartPage;
                      },
                    ),
                  );
                },
                child: Text(
                  "Start Campaign",
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
                        return lastProgressPage;
                      },
                    ),
                  );
                },
                child: Text(
                  "Continue Last Progress",
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
