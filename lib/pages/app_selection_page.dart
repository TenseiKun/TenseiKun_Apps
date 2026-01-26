import 'package:flutter/material.dart';
import 'package:tenseikun_apps/model/app_model.dart';
import 'package:tenseikun_apps/pages/applications/1_calculator/calculator_page.dart';
import 'package:tenseikun_apps/pages/applications/2_ticTacToe/ttt_page.dart';
import 'package:tenseikun_apps/pages/applications/3_daily_apps/daily_apps_selection_page.dart';

import '../widgets/icon_buttons_widgets.dart';

class AppSelectionPage extends StatefulWidget {
  const AppSelectionPage({super.key});

  @override
  State<AppSelectionPage> createState() => _AppSelectionPageState();
}

List<Apps> appList = [
  Apps(
    appTitle: "Calculator App",
    appDesc: "App for calculating two numbers!",
    appType: Calculator(),
  ),
  Apps(
    appTitle: "Tic-tac-toe Game",
    appDesc: "App for playing tic tac toe",
    appType: TicTacToe(),
  ),
  Apps(
      appTitle: "Daily Apps",
      appDesc: "Common Apps that we always use daily",
      appType: DailyAppsSelectionPage()),
];

class _AppSelectionPageState extends State<AppSelectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TenseiApps"),
        actions: [
          ThemeIconButton(),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              spacing: 10,
              children: [
                ...List.generate(
                  appList.length,
                  (index) {
                    return Card(
                      child: ListTile(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return appList[index].appType!;
                            },
                          ));
                        },
                        title: Text(
                          appList[index].appTitle,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(appList[index].appDesc),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
