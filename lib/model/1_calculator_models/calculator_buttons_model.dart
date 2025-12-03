import 'package:flutter/material.dart';
import 'package:tenseikun_apps/data/notifiers.dart';
import 'package:tenseikun_apps/widgets/const_widgets_1_calculator/container_widgets.dart';

class CalcBtn {
  static final String zeroKey = "0";
  static final String oneKey = "1";
  static final String twoKey = "2";
  static final String threeKey = "3";
  static final String fourKey = "4";
  static final String fiveKey = "5";
  static final String sixKey = "6";
  static final String sevenKey = "7";
  static final String eightKey = "8";
  static final String nineKey = "9";
  static final String dotKey = ".";

  static final String equalKey = "=";
  static final String plusKey = "+";
  static final String minusKey = "-";
  static final String multiplyKey = "\u00D7";
  static final String divideKey = "\u00F7";

  static final String deleteKey = "DEL";
  static final String clearKey = "CLR";
  static final String backKey = "BACK";
  static final String percentKey = "%";
}

class CalcKeyBtn extends StatelessWidget {
  const CalcKeyBtn({super.key, required this.btnKey, required this.onPressed});

  final String btnKey;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ContainerForCalcBtn(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: btnKey == CalcBtn.equalKey ||
                    btnKey == "\u2713" ||
                    btnKey == CalcBtn.backKey
                ? Colors.blue[700]
                : btnKey == CalcBtn.plusKey ||
                        btnKey == CalcBtn.minusKey ||
                        btnKey == CalcBtn.multiplyKey ||
                        btnKey == CalcBtn.divideKey ||
                        btnKey == CalcBtn.percentKey
                    ? Colors.blueGrey[700]
                    : btnKey == CalcBtn.deleteKey || btnKey == CalcBtn.clearKey
                        ? Colors.red[300]
                        : null),
        onPressed: onPressed,
        child: FittedBox(
          child: ValueListenableBuilder(
            valueListenable: isDarkModeTheme,
            builder: (context, isDarkModeThemeState, child) {
              return Text(
                btnKey,
                style: TextStyle(
                    fontSize: 30,
                    color: isDarkModeThemeState ? Colors.white : Colors.black),
              );
            },
          ),
        ),
      ),
    );
  }
}
