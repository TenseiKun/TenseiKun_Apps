import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tenseikun_apps/pages/applications/3_daily_apps/daily_apps_pages/clock/stopwatch.dart';
import 'package:tenseikun_apps/pages/applications/3_daily_apps/daily_apps_pages/clock/timer.dart';
import 'package:tenseikun_apps/pages/applications/3_daily_apps/daily_apps_pages/clock/world_clock.dart';

import '../../../../../widgets/icon_buttons_widgets.dart';

class Clock extends StatefulWidget {
  const Clock({super.key});

  @override
  State<Clock> createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  int currentPage = 0;

  final List<Widget> pages = [
    ClockPage(),
    TimerPage(),
    StopWatchPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TenseiApps: Daily Apps"),
        actions: [
          ThemeIconButton(),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: IndexedStack(
        index: currentPage,
        children: pages,
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashFactory: NoSplash.splashFactory,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          selectedItemColor: Colors.blueGrey,
          selectedLabelStyle:
              TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          unselectedFontSize: 15,
          currentIndex: currentPage,
          onTap: (index) {
            setState(() {
              currentPage = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.clock),
              label: 'Clock',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.hourglassHalf),
              label: 'Timer',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.stopwatch),
              label: 'Stopwatch',
            ),
          ],
        ),
      ),
    );
  }
}
