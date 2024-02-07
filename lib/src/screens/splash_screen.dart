import 'dart:async';
import 'package:flutter/material.dart';

import 'package:task_1/src/screens/intro_screen/intro_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController scaleController;
  late Animation<double> scaleAnimation;

  double _opacity = 0;
  final double _containerSize = 1.5;

  @override
  void initState() {
    super.initState();

    scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const SecondPage(),
              ),
              (route) => false,
            );
          }
        },
      );

    scaleAnimation =
        Tween<double>(begin: 0.0, end: 12).animate(scaleController);

    Timer(const Duration(milliseconds: 600), () {
      setState(() {
        _opacity = 1.0;
      });
    });
    Timer(const Duration(milliseconds: 2000), () {
      setState(() {
        scaleController.forward().then((value) {
          scaleController.stop();
          scaleController.reset();
        });
      });
    });
  }

  @override
  void dispose() {
    scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: AnimatedOpacity(
          curve: Curves.easeInCirc,
          duration: const Duration(milliseconds: 1700),
          opacity: _opacity,
          child: AnimatedContainer(
            curve: Curves.easeInCirc,
            duration: const Duration(milliseconds: 1700),
            height: width / _containerSize,
            width: width / _containerSize,
            child: Column(
              children: [
                Image.asset(
                  'assets/img/ganesh.png',
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width,
                ),
                const Text(
                  'Shree Ganesh Stationary',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IntroScreen(),
    );
  }
}
