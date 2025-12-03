import 'package:flutter/material.dart';
import 'package:tenseikun_apps/widgets/icon_buttons_widgets.dart';
import '../../../model/1_calculator_models/calculator_buttons_model.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

String num1 = "0";
String result = "100";

class _CalculatorState extends State<Calculator> {
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
            onPressed: () {
              print(screenHeight);
            },
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
            child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 5, right: 15),
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
                    if (screenHeight >= 500)
                      Opacity(
                        opacity: 0.5,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            result,
                            style: TextStyle(
                              fontSize: 30,
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
                          num1,
                          style: TextStyle(
                            fontSize: 50,
                          ),
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
                      CalcKeyBtn(btnKey: CalcBtn.deleteKey, onPressed: () {}),
                      CalcKeyBtn(
                          btnKey: CalcBtn.clearKey,
                          onPressed: () {
                            num1 = "0";
                            setState(() {});
                          }),
                      CalcKeyBtn(btnKey: CalcBtn.percentKey, onPressed: () {}),
                      CalcKeyBtn(btnKey: CalcBtn.divideKey, onPressed: () {}),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CalcKeyBtn(
                          btnKey: CalcBtn.sevenKey,
                          onPressed: () {
                            num1 += CalcBtn.sevenKey;
                            setState(() {});
                          }),
                      CalcKeyBtn(
                          btnKey: CalcBtn.eightKey,
                          onPressed: () {
                            num1 += CalcBtn.eightKey;
                            setState(() {});
                          }),
                      CalcKeyBtn(
                          btnKey: CalcBtn.nineKey,
                          onPressed: () {
                            num1 += CalcBtn.nineKey;
                            setState(() {});
                          }),
                      CalcKeyBtn(btnKey: CalcBtn.multiplyKey, onPressed: () {}),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CalcKeyBtn(
                          btnKey: CalcBtn.fourKey,
                          onPressed: () {
                            num1 += CalcBtn.fourKey;
                            setState(() {});
                          }),
                      CalcKeyBtn(
                          btnKey: CalcBtn.fiveKey,
                          onPressed: () {
                            num1 += CalcBtn.fiveKey;
                            setState(() {});
                          }),
                      CalcKeyBtn(
                          btnKey: CalcBtn.sixKey,
                          onPressed: () {
                            num1 += CalcBtn.sixKey;
                            setState(() {});
                          }),
                      CalcKeyBtn(btnKey: CalcBtn.minusKey, onPressed: () {}),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CalcKeyBtn(
                          btnKey: CalcBtn.oneKey,
                          onPressed: () {
                            num1 += CalcBtn.oneKey;
                            setState(() {});
                          }),
                      CalcKeyBtn(
                          btnKey: CalcBtn.twoKey,
                          onPressed: () {
                            num1 += CalcBtn.twoKey;
                            setState(() {});
                          }),
                      CalcKeyBtn(
                          btnKey: CalcBtn.threeKey,
                          onPressed: () {
                            num1 += CalcBtn.threeKey;
                            setState(() {});
                          }),
                      CalcKeyBtn(btnKey: CalcBtn.plusKey, onPressed: () {}),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: CalcKeyBtn(
                                btnKey: CalcBtn.zeroKey, onPressed: () {}),
                          )),
                      CalcKeyBtn(btnKey: CalcBtn.dotKey, onPressed: () {}),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: CalcKeyBtn(
                            btnKey: CalcBtn.equalKey, onPressed: () {}),
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
