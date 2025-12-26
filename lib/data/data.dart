import 'package:shared_preferences/shared_preferences.dart';
import 'package:tenseikun_apps/data/2_TicTacToe/data_tictactoe.dart';
import 'package:tenseikun_apps/data/constants.dart';
import 'package:tenseikun_apps/data/notifiers.dart';

Future loadEverything() async {
  loadAppTheme();
  loadTicTacToeUsers();
}

Future loadAppTheme() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool? appTheme = prefs.getBool(Kkeys.appThemeKey);
  isDarkModeTheme.value = appTheme ?? true;
}

Future saveAppTheme(bool appTheme) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool(Kkeys.appThemeKey, appTheme);
}
