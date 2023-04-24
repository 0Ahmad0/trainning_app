import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Center(
          child: SizedBox(
            height: 100,
            child: Image.asset(
              'assets/entern_logo.png',
            ),
          ),
        ),
      ),
    );
  }
}
