import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tenseikun_apps/data/constants.dart';
import 'package:tenseikun_apps/model/2_ticTacToe_models/player_models.dart';

Future<List<Users>> loadTicTacToeUsers() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? usersJson = prefs.getString(Kkeys.ticTacToeUsersListKey);
  if (usersJson == null) return [];
  final List<dynamic> usersList = jsonDecode(usersJson);
  return usersList.map((json) => Users.fromJsonTTT(json)).toList();
}

Future saveTicTacToeUsers(List<Users> users) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final usersListJson = users.map((user) => user.toJsonTTT()).toList();
  final usersJson = jsonEncode(usersListJson);
  return await prefs.setString(Kkeys.ticTacToeUsersListKey, usersJson);
}

Future<String> loadRecentTicTacToeUser(bool player1Choosing) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? recentUser = prefs.getString(player1Choosing
      ? Kkeys.ticTacToeRecentUserP1
      : Kkeys.ticTacToeRecentUserP2);
  if (recentUser == null) return "Bob";
  return recentUser;
}

Future saveRecentTicTacToeUser(bool player1Choosing, String recentUser) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return await prefs.setString(
      player1Choosing
          ? Kkeys.ticTacToeRecentUserP1
          : Kkeys.ticTacToeRecentUserP2,
      recentUser);
}
