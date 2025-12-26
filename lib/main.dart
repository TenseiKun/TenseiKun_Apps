import 'package:flutter/material.dart';
import 'package:tenseikun_apps/data/data.dart';
import 'package:tenseikun_apps/data/notifiers.dart';
import 'package:tenseikun_apps/pages/app_selection_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadEverything();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: isDarkModeTheme,
        builder: (context, isDarkModestate, child) {
          return MaterialApp(
            theme: ThemeData(
              cardTheme: CardTheme(
                color: Colors.green,
              ),
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.green,
                brightness:
                    isDarkModestate ? Brightness.dark : Brightness.light,
              ),
              appBarTheme: AppBarTheme(
                titleTextStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: isDarkModestate ? Colors.white : Colors.black),
                centerTitle: true,
              ),
            ),
            debugShowCheckedModeBanner: false,
            home: AppSelectionPage(),
          );
        });
  }
}
