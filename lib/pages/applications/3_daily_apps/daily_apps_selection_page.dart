import 'package:flutter/material.dart';
import 'package:tenseikun_apps/pages/applications/1_calculator/calculator_page.dart';
import 'package:tenseikun_apps/pages/applications/3_daily_apps/daily_apps_pages/clock/clock_page.dart';

import '../../../model/3_dailyApps_models/daily_apps_models.dart';
import '../../../widgets/icon_buttons_widgets.dart';
import '../../../widgets/widgets_3_dailyApps/container_widgets.dart';

class DailyAppsSelectionPage extends StatefulWidget {
  const DailyAppsSelectionPage({super.key});

  @override
  State<DailyAppsSelectionPage> createState() => _DailyAppsSelectionPageState();
}

List<DailyApps> dailyAppsList = [
  DailyApps(
      appName: "Browser",
      appIcon: "assets/images/placeholder_image.jpg",
      appType: Calculator()),
  DailyApps(
      appName: "Calculator",
      appIcon: "assets/images/placeholder_image.jpg",
      appType: Calculator()),
  DailyApps(
    appName: "Camera",
    appIcon: "assets/images/placeholder_image.jpg",
    appType: Calculator(),
  ),
  DailyApps(
    appName: "Clock",
    appIcon: "assets/images/placeholder_image.jpg",
    appType: Clock(),
  ),
  DailyApps(
    appName: "Compass",
    appIcon: "assets/images/placeholder_image.jpg",
    appType: Calculator(),
  ),
  DailyApps(
    appName: "Contacts",
    appIcon: "assets/images/placeholder_image.jpg",
    appType: Calculator(),
  ),
  DailyApps(
    appName: "Music Player",
    appIcon: "assets/images/placeholder_image.jpg",
    appType: Calculator(),
  ),
  DailyApps(
    appName: "Notes",
    appIcon: "assets/images/placeholder_image.jpg",
    appType: Calculator(),
  ),
  DailyApps(
    appName: "Photo Viewer",
    appIcon: "assets/images/placeholder_image.jpg",
    appType: Calculator(),
  ),
  DailyApps(
    appName: "Sound Recorder",
    appIcon: "assets/images/placeholder_image.jpg",
    appType: Calculator(),
  ),
  DailyApps(
    appName: "Video Viewer",
    appIcon: "assets/images/placeholder_image.jpg",
    appType: Calculator(),
  ),
  DailyApps(
    appName: "Weather",
    appIcon: "assets/images/placeholder_image.jpg",
    appType: Calculator(),
  ),
];

class _DailyAppsSelectionPageState extends State<DailyAppsSelectionPage> {
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
      body: GridView.builder(
        itemCount: dailyAppsList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: (context, index) {
          return DailyAppSelectGrid(
              appIcon: dailyAppsList[index].appIcon,
              appName: dailyAppsList[index].appName,
              appType: dailyAppsList[index].appType!);
        },
      ),
    );
  }
}
