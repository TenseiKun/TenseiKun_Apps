import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tenseikun_apps/data/constants.dart';

Future<DateTime> getTime(String location) async {
  final response = await get(
    Uri.parse('https://time.now/developer/api/timezone/$location'),
  ).timeout(const Duration(seconds: 10));

  if (response.statusCode != 200) {
    throw HttpException('HTTP ${response.statusCode}');
  }

  final data = jsonDecode(response.body);

  final utc = DateTime.parse(data['utc_datetime']);
  final int offsetSeconds = data['raw_offset'];

  return utc.add(Duration(seconds: offsetSeconds));
}

Future saveTimeZone(String timeZone) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return await prefs.setString(Kkeys.savedTimeZoneKey, timeZone);
}

Future<String> loadTimeZone() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? timeZone = prefs.getString(Kkeys.savedTimeZoneKey);
  if (timeZone == null) return await FlutterTimezone.getLocalTimezone();
  return timeZone;
}
