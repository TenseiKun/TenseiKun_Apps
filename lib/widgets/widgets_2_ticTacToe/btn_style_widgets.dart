import 'package:flutter/material.dart';

ButtonStyle forGradientBtnStyle() {
  return ElevatedButton.styleFrom(
    elevation: 0,
    backgroundColor: Colors.transparent,
    overlayColor: Colors.transparent,
    splashFactory: NoSplash.splashFactory,
  );
}

ButtonStyle forSelectBtnStyle(Color btnColor) {
  return ElevatedButton.styleFrom(
    elevation: 0,
    backgroundColor: btnColor,
    overlayColor: Colors.transparent,
    splashFactory: NoSplash.splashFactory,
  );
}
