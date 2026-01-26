import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../data/3_dailyApps/clock/clock_data.dart';
import '../../../../../widgets/widgets_3_dailyApps/column_widgets.dart';

class ClockPage extends StatefulWidget {
  const ClockPage({super.key});

  @override
  State<ClockPage> createState() => _ClockPageState();
}

bool isTimeReady = false;

class _ClockPageState extends State<ClockPage> {
  late DateTime currentTime;
  String? selectedTimeZone;
  String? defaultTimeZone;
  Timer? clockTimer;

  String? time;
  String? date;
  String? day;

  @override
  void initState() {
    super.initState();
    initClock();
  }

  Future initClock() async {
    setState(() => isTimeReady = false);
    defaultTimeZone = await loadTimeZone();
    await readyClock(defaultTimeZone!);
    startTicking();
  }

  @override
  void dispose() {
    clockTimer?.cancel();
    super.dispose();
  }

  Future readyClock(String timeZone) async {
    setState(() => isTimeReady = false);
    try {
      currentTime = await getTime(timeZone);

      time = DateFormat('jms').format(currentTime);
      date = DateFormat('yMMMMd').format(currentTime);
      day = DateFormat('EEEE').format(currentTime);
    } on SocketException {
      useDeviceTime("No internet connection");
    } on TimeoutException {
      useDeviceTime("Connection too slow");
    } on HttpException {
      useDeviceTime("Server error");
    } catch (_) {
      useDeviceTime("Unknown error");
    }

    setState(() => isTimeReady = true);
  }

  void useDeviceTime(String message) {
    currentTime = DateTime.now();

    time = DateFormat('jms').format(currentTime);
    date = DateFormat('yMMMMd').format(currentTime);
    day = DateFormat('EEEE').format(currentTime);
    selectedTimeZone = defaultTimeZone;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
      ),
    );
  }

  void startTicking() {
    clockTimer?.cancel();

    clockTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;

      currentTime = currentTime.add(const Duration(seconds: 1));

      if (currentTime.hour == 0 &&
          currentTime.minute == 0 &&
          currentTime.second == 0) {
        clockTimer?.cancel();
        readyClock(selectedTimeZone ?? defaultTimeZone!);
        return;
      }

      setState(() {
        time = DateFormat('jms').format(currentTime);
        date = DateFormat('yMMMMd').format(currentTime);
        day = DateFormat('EEEE').format(currentTime);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height - 100;
    return !isTimeReady
        ? Center(child: const CircularProgressIndicator())
        : Padding(
            padding: const EdgeInsets.all(12),
            child: SingleChildScrollView(
              child: Column(
                spacing: screenHeight >= 420 ? 100 : 10,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TimezoneDropdown(
                    onChanged: (selectedTimeZone) {
                      this.selectedTimeZone = selectedTimeZone;
                      saveTimeZone(selectedTimeZone);
                      readyClock(selectedTimeZone);
                      startTicking();
                    },
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 2,
                    children: [
                      Text(
                        selectedTimeZone ?? defaultTimeZone!,
                        style: TextStyle(fontSize: 15),
                      ),
                      Text(
                        time ?? "Didn't load",
                        style: TextStyle(fontSize: 50),
                      ),
                      Text(
                        date ?? "Didn't load",
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        day ?? "Didn't load",
                        style: TextStyle(fontSize: 35),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
  }
}
