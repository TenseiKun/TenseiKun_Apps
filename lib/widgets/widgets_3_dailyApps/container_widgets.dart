import 'package:flutter/material.dart';

class DailyAppSelectGrid extends StatelessWidget {
  const DailyAppSelectGrid(
      {super.key,
      required this.appIcon,
      required this.appName,
      required this.appType});

  final String appIcon;
  final String appName;
  final Widget appType;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height - 100;
    // double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => appType,
            ));
      },
      child: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: Colors.grey,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            SizedBox(
              height: screenHeight >= 420 ? 60 : 130,
              width: screenHeight >= 420 ? 60 : 130,
              child: Image.asset(
                appIcon,
                fit: BoxFit.cover,
              ),
            ),
            FittedBox(
              child: Text(
                appName,
                style: TextStyle(
                    fontSize: screenHeight >= 420 ? 12 : 24,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
