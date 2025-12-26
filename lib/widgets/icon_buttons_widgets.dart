import 'package:flutter/material.dart';
import 'package:tenseikun_apps/data/data.dart';
import 'package:tenseikun_apps/data/notifiers.dart';

class ThemeIconButton extends StatelessWidget {
  const ThemeIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isDarkModeTheme,
      builder: (context, isDarkModeThemeState, child) {
        return IconButton(
          onPressed: () {
            isDarkModeTheme.value = !isDarkModeTheme.value;
            saveAppTheme(isDarkModeTheme.value);
          },
          icon:
              Icon(isDarkModeTheme.value ? Icons.dark_mode : Icons.light_mode),
        );
      },
    );
  }
}
