import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../../widgets/widgets_3_dailyApps/button_widgets.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  Timer? timer;
  int time = 0;
  int maxTime = 0;
  bool isPaused = false;
  bool noTimer = true;
  TextEditingController hourController = TextEditingController(text: "0");
  TextEditingController minController = TextEditingController(text: "0");
  TextEditingController secController = TextEditingController(text: "0");

  void startTimer() {
    setState(() {});
    if (noTimer == false && isPaused == true) {
      timer?.cancel();
      isPaused = false;
      noTimer = true;
      setState(() {
        time = 0;
        hourController.text = "0";
        minController.text = "0";
        secController.text = "0";
      });
      return;
    }

    if (noTimer == true) {
      int h = int.tryParse(hourController.text) ?? 0;
      int m = int.tryParse(minController.text) ?? 0;
      int s = int.tryParse(secController.text) ?? 0;

      maxTime = h * 3600 + m * 60 + s;
      if (maxTime == 0) return;

      time = maxTime;
      noTimer = false;
      isPaused = false;

      timer = Timer.periodic(
        const Duration(seconds: 1),
        (_) {
          if (time > 0) {
            setState(() {
              time--;
            });
          }
        },
      );
    } else if (isPaused == false) {
      timer?.cancel();
      noTimer = true;
      setState(() {
        time = 0;
        hourController.text = "0";
        minController.text = "0";
        secController.text = "0";
      });
    } else {
      isPaused = false;
      timer = Timer.periodic(
        const Duration(seconds: 1),
        (_) {
          if (time > 0) {
            setState(() {
              time--;
            });
          }
        },
      );
    }
  }

  void pauseTimer() {
    setState(() {});
    if (isPaused == false) {
      isPaused = true;
      timer?.cancel();
      setState(() {});
    } else {
      isPaused = false;
      timer = Timer.periodic(
        const Duration(seconds: 1),
        (_) {
          if (time > 0) {
            setState(() {
              time--;
            });
          }
        },
      );
    }
  }

  Widget inputTime() {
    if (!noTimer) {
      return SizedBox(
        height: 300,
        width: 300,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CircularProgressIndicator(
              value: time / maxTime,
              strokeWidth: 8,
            ),
            Center(
              child: Text(
                "${(time ~/ 3600).toString().padLeft(2, '0')}:${((time % 3600) ~/ 60).toString().padLeft(2, '0')}:${(time % 60).toString().padLeft(2, '0')}",
                style: TextStyle(fontSize: 50),
              ),
            ),
          ],
        ),
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 15,
        children: [
          SizedBox(
            width: 60,
            child: TextField(
              controller: hourController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                  labelText: 'HH', border: OutlineInputBorder()),
            ),
          ),
          SizedBox(
            width: 60,
            child: TextField(
              controller: minController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                  labelText: 'MM', border: OutlineInputBorder()),
            ),
          ),
          SizedBox(
            width: 60,
            child: TextField(
              controller: secController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                  labelText: 'SS', border: OutlineInputBorder()),
            ),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height - 100;
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 30,
          children: [
            if (screenHeight <= 420)
              SizedBox(
                height: 10,
              ),
            inputTime(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 5,
              children: [
                TimerNWatchButtons(
                    text: noTimer ? "Start Timer" : "Reset Timer",
                    onPressed: () {
                      startTimer();
                    }),
                if (noTimer == false && time != 0)
                  TimerNWatchButtons(
                    text: isPaused ? 'Resume Timer' : 'Pause Timer',
                    onPressed: () {
                      pauseTimer();
                    },
                  ),
              ],
            ),
            if (screenHeight <= 420)
              SizedBox(
                height: 10,
              ),
          ],
        ),
      ),
    );
  }
}
