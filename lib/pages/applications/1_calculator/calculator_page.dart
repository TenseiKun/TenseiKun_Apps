import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:tenseikun_apps/widgets/icon_buttons_widgets.dart';
import '../../../model/1_calculator_models/calculator_buttons_model.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String number = "0";
  String result = "0";
  bool nextNumber = false;
  bool showResult = false;

  List<dynamic> numbers = [];
  List<dynamic> operators = [];

  void onClickCalcBtn(String calcValue) {
    if (calcValue != CalcBtn.clearKey &&
        calcValue != CalcBtn.deleteKey &&
        calcValue != CalcBtn.equalKey &&
        calcValue != CalcBtn.percentKey &&
        calcValue != CalcBtn.backKey) {
      addNumber(calcValue);
    } else if (calcValue == CalcBtn.clearKey ||
        calcValue == CalcBtn.deleteKey) {
      deleteNumber(calcValue);
    } else if (calcValue == CalcBtn.equalKey || calcValue == CalcBtn.backKey) {
      showEqual(calcValue);
    } else if (calcValue == CalcBtn.percentKey) {
      result = percentageExpression(number);
      setState(() {});
      return;
    }
    calculateExpression(number);
    setState(() {});
  }

  void addNumber(String input) {
    if (showResult) {
      showResult = false;
      nextNumber = false;
      number = result;
    }
    if (number == "0") {
      number = input;
    } else if (nextNumber) {
      number = number.substring(0, number.length - 1);
      number += input;
      nextNumber = false;
    } else if (input == CalcBtn.plusKey ||
        input == CalcBtn.minusKey ||
        input == CalcBtn.multiplyKey ||
        input == CalcBtn.divideKey) {
      number += input;
      number += "0";
      nextNumber = true;
    } else {
      number += input;
    }
  }

  void deleteNumber(String input) {
    if (showResult) {
      showResult = false;
      nextNumber = false;
      number = result;
    }
    if (input == CalcBtn.clearKey) {
      number = "0";
      nextNumber = false;
    } else {
      number = number.substring(0, number.length - 1);
      if (number.isEmpty) {
        number = "0";
      } else if (number.endsWith(CalcBtn.plusKey) ||
          number.endsWith(CalcBtn.minusKey) ||
          number.endsWith(CalcBtn.multiplyKey) ||
          number.endsWith(CalcBtn.divideKey)) {
        number = number.substring(0, number.length - 1);
        nextNumber = false;
      }
    }
  }

  String calculateExpression(String expression) {
    try {
      Parser p = Parser();
      Expression exp = p.parse(expression);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      if (eval.toString().endsWith("0")) {
        return result = eval.toInt().toString();
      } else {
        return result = eval.toString();
      }
      // eval.toString().replaceAll(RegExp(r"\.0$"), "");
    } catch (e) {
      return "Error";
    }
  }

  String percentageExpression(String expression) {
    try {
      double toBeConverted = double.parse(result);
      double eval = toBeConverted / 100;
      print(eval);
      showResult = true;
      return eval.toString();
      // eval.toString().replaceAll(RegExp(r"\.0$"), "");
    } catch (e) {
      return "Error";
    }
  }

  void showEqual(String calcValue) {
    showResult = !showResult;
    if (!showResult && calcValue == CalcBtn.equalKey) {
      number = "0";
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height - 100;
    double panelForOutput = screenHeight * 0.3;
    double panelForKeys = screenHeight * 0.7;
    return Scaffold(
      appBar: AppBar(
        title: Text("TenseiApps: Calculator"),
        actions: [
          ThemeIconButton(),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
            child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                  bottom: screenHeight >= 500 ? 20 : 10, right: 15),
              height: panelForOutput,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.grey[600],
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              child: SingleChildScrollView(
                reverse: true,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (screenHeight >= 500 && !showResult)
                      Opacity(
                        opacity: 0.5,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: FittedBox(
                            child: Text(
                              result,
                              style: TextStyle(
                                fontSize: 30,
                              ),
                            ),
                          ),
                        ),
                      ),
                    Align(
                      alignment: screenHeight <= 500
                          ? Alignment.centerRight
                          : Alignment.bottomRight,
                      child: FittedBox(
                        child: Text(
                          showResult ? result : number,
                          style: TextStyle(
                              fontSize: screenHeight >= 500 ? 50 : 40,
                              fontWeight: showResult
                                  ? FontWeight.bold
                                  : FontWeight.normal),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              height: panelForKeys,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CalcKeyBtn(
                        btnKey: CalcBtn.deleteKey,
                        onPressed: () => onClickCalcBtn(CalcBtn.deleteKey),
                      ),
                      CalcKeyBtn(
                        btnKey: CalcBtn.clearKey,
                        onPressed: () => onClickCalcBtn(CalcBtn.clearKey),
                      ),
                      CalcKeyBtn(
                        btnKey: CalcBtn.percentKey,
                        onPressed: () => onClickCalcBtn(CalcBtn.percentKey),
                      ),
                      CalcKeyBtn(
                        btnKey: CalcBtn.divideKey,
                        onPressed: () => onClickCalcBtn(CalcBtn.divideKey),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CalcKeyBtn(
                        btnKey: CalcBtn.sevenKey,
                        onPressed: () => onClickCalcBtn(CalcBtn.sevenKey),
                      ),
                      CalcKeyBtn(
                        btnKey: CalcBtn.eightKey,
                        onPressed: () => onClickCalcBtn(CalcBtn.eightKey),
                      ),
                      CalcKeyBtn(
                        btnKey: CalcBtn.nineKey,
                        onPressed: () => onClickCalcBtn(CalcBtn.nineKey),
                      ),
                      CalcKeyBtn(
                        btnKey: CalcBtn.multiplyKey,
                        onPressed: () => onClickCalcBtn(CalcBtn.multiplyKey),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CalcKeyBtn(
                        btnKey: CalcBtn.fourKey,
                        onPressed: () => onClickCalcBtn(CalcBtn.fourKey),
                      ),
                      CalcKeyBtn(
                        btnKey: CalcBtn.fiveKey,
                        onPressed: () => onClickCalcBtn(CalcBtn.fiveKey),
                      ),
                      CalcKeyBtn(
                        btnKey: CalcBtn.sixKey,
                        onPressed: () => onClickCalcBtn(CalcBtn.sixKey),
                      ),
                      CalcKeyBtn(
                        btnKey: CalcBtn.minusKey,
                        onPressed: () => onClickCalcBtn(CalcBtn.minusKey),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CalcKeyBtn(
                        btnKey: CalcBtn.oneKey,
                        onPressed: () => onClickCalcBtn(CalcBtn.oneKey),
                      ),
                      CalcKeyBtn(
                        btnKey: CalcBtn.twoKey,
                        onPressed: () => onClickCalcBtn(CalcBtn.twoKey),
                      ),
                      CalcKeyBtn(
                        btnKey: CalcBtn.threeKey,
                        onPressed: () => onClickCalcBtn(CalcBtn.threeKey),
                      ),
                      CalcKeyBtn(
                        btnKey: CalcBtn.plusKey,
                        onPressed: () => onClickCalcBtn(CalcBtn.plusKey),
                      ),
                    ],
                  ),
                  if (!showResult)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: CalcKeyBtn(
                              btnKey: CalcBtn.zeroKey,
                              onPressed: () => onClickCalcBtn(CalcBtn.zeroKey),
                            ),
                          ),
                        ),
                        CalcKeyBtn(
                          btnKey: showResult ? CalcBtn.backKey : CalcBtn.dotKey,
                          onPressed: () => onClickCalcBtn(
                              showResult ? CalcBtn.backKey : CalcBtn.dotKey),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: CalcKeyBtn(
                            btnKey: showResult ? "\u2713" : CalcBtn.equalKey,
                            onPressed: () => onClickCalcBtn(CalcBtn.equalKey),
                          ),
                        ),
                      ],
                    ),
                  if (showResult)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CalcKeyBtn(
                          btnKey: CalcBtn.zeroKey,
                          onPressed: () => onClickCalcBtn(CalcBtn.zeroKey),
                        ),
                        CalcKeyBtn(
                          btnKey: CalcBtn.dotKey,
                          onPressed: () => onClickCalcBtn(CalcBtn.dotKey),
                        ),
                        CalcKeyBtn(
                          btnKey: CalcBtn.backKey,
                          onPressed: () => onClickCalcBtn(CalcBtn.backKey),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: CalcKeyBtn(
                            btnKey: showResult ? "\u2713" : CalcBtn.equalKey,
                            onPressed: () => onClickCalcBtn(CalcBtn.equalKey),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}
