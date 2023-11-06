// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_1/src/screens/sign_in/bloc/sign_in_bloc.dart';
import 'package:task_1/src/screens/sign_in/sign_in_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  late PageController _pageController;
  int currentIndex = 0;

  static const _kDuration = Duration(milliseconds: 300);
  static const _kCurve = Curves.ease;

  final List<Map<String, dynamic>> cardData = [
    {
      "image": 'assets/img/boarding_screen/first.jpg',
      "title": 'School Wise Stationary',
      "description": 'Easily Get Your Stationary Products To Your School',
    },
    {
      "image": 'assets/img/boarding_screen/second.jpg',
      "title": 'Discount',
      "description": 'More Discount To Market',
    },
    {
      "image": 'assets/img/boarding_screen/third.jpg',
      "title": 'Payment',
      "description": 'Easy To Use Online And Offline Payment',
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void nextFunction() {
    _pageController.nextPage(duration: _kDuration, curve: _kCurve);
  }

  void onChangedFunction(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PageView(
            controller: _pageController,
            onPageChanged: onChangedFunction,
            children: cardData.map((data) {
              return Container(
                padding: const EdgeInsets.only(top: 50),
                child: Column(
                  children: [
                    Image.asset(data["image"]),
                    const SizedBox(height: 5),
                    Text(
                      data["title"],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      data["description"],
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          Positioned(
            bottom: 20,
            left: 25,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Row(
                children: [
                  if (currentIndex < cardData.length - 1)
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => BlocProvider<SignInBloc>(
                                create: (context) => SignInBloc(),
                                child: const SignInScreen(),
                              ),
                            ),
                            (route) => false);
                      },
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue[700],
                        ),
                      ),
                    ),
                  const SizedBox(width: 80),
                  _buildPaginationDots(),
                  const SizedBox(width: 115),
                  if (currentIndex < cardData.length - 1)
                    IconButton(
                      onPressed: nextFunction,
                      icon: Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Colors.blue[700],
                      ),
                    ),
                  const SizedBox(
                    width: 35,
                  ),
                  if (currentIndex == cardData.length - 1)
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => BlocProvider<SignInBloc>(
                                create: (context) => SignInBloc(),
                                child: const SignInScreen(),
                              ),
                            ),
                            (route) => false);
                      },
                      child: Text(
                        'Done',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue[700],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaginationDots() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        cardData.length,
        (index) => Container(
          width: 8.0,
          height: 8.0,
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: currentIndex == index ? Colors.blue : Colors.grey,
          ),
        ),
      ),
    );
  }
}
