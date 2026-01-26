import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tenseikun_apps/data/notifiers.dart';

import '../../../../../widgets/widgets_3_dailyApps/button_widgets.dart';

class StopWatchPage extends StatefulWidget {
  const StopWatchPage({super.key});

  @override
  State<StopWatchPage> createState() => _StopWatchPageState();
}

class _StopWatchPageState extends State<StopWatchPage> {
  List<String> stampedTimes = [];
  Timer? watch;
  int time = 0;
  int lastTime = 0;
  bool isPaused = false;
  bool noWatch = true;

  String formatTime(int time) {
    return "${(time ~/ 3600).toString().padLeft(2, '0')}:"
        "${((time % 3600) ~/ 60).toString().padLeft(2, '0')}:"
        "${(time % 60).toString().padLeft(2, '0')}";
  }

  void startWatch() {
    setState(() {});
    if (noWatch == false && isPaused == true) {
      watch?.cancel();
      isPaused = false;
      noWatch = true;
      setState(() {
        time = 0;
      });
      return;
    }

    if (noWatch == true) {
      time = 0;
      noWatch = false;
      isPaused = false;
      stampedTimes.clear();

      watch = Timer.periodic(
        const Duration(seconds: 1),
        (_) {
          setState(() {
            time++;
          });
        },
      );
    } else if (isPaused == false) {
      watch?.cancel();
      noWatch = true;
      setState(() {
        lastTime = time;
        time = 0;
      });
    } else {
      isPaused = false;
      watch = Timer.periodic(
        const Duration(seconds: 1),
        (_) {
          setState(() {
            time++;
          });
        },
      );
    }
  }

  void pauseWatch() {
    setState(() {});
    if (isPaused == false) {
      isPaused = true;
      watch?.cancel();
      setState(() {});
    } else {
      isPaused = false;
      watch = Timer.periodic(
        const Duration(seconds: 1),
        (_) {
          setState(() {
            time++;
          });
        },
      );
    }
  }

  void addStampTime() {
    String stampedTime = formatTime(time);
    stampedTimes.add(stampedTime);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height - 100;
    double screenWidth = MediaQuery.of(context).size.width;
    return Center(
        child: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: screenHeight >= 420 ? screenHeight * 0.4 : screenHeight * 1,
            width: screenWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 15,
              children: [
                Column(
                  children: [
                    Text(
                      formatTime(time),
                      style: TextStyle(fontSize: 50),
                    ),
                    if (noWatch == true)
                      Text(
                        formatTime(lastTime),
                        style: TextStyle(fontSize: 15),
                      ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 5,
                  children: [
                    TimerNWatchButtons(
                        text: noWatch ? "Start Watch" : "Reset Watch",
                        onPressed: () {
                          startWatch();
                        }),
                    if (noWatch == false)
                      TimerNWatchButtons(
                        text: isPaused ? 'Resume Watch' : 'Pause Watch',
                        onPressed: () {
                          pauseWatch();
                        },
                      ),
                  ],
                ),
                if (noWatch == false)
                  TimerNWatchButtons(
                    text: "Stamp time",
                    onPressed: () {
                      addStampTime();
                    },
                  ),
              ],
            ),
          ),
          SizedBox(
            height:
                screenHeight >= 420 ? screenHeight * 0.05 : screenHeight * 0.1,
          ),
          Container(
            height:
                screenHeight >= 420 ? screenHeight * 0.4 : screenHeight * 0.6,
            width: screenWidth * 0.6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  width: 2,
                  color: isDarkModeTheme.value ? Colors.white : Colors.black),
            ),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: stampedTimes.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Text("#${index + 1}"),
                        title: Text(stampedTimes[index]),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
