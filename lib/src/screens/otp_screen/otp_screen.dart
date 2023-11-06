import 'package:flutter/material.dart';
import 'dart:async';
import '../bottom_navigation_bar.dart/bottom_navigation.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  Timer? countdownTimer;
  int myDuration = 16;

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  void startTimer() {
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (myDuration == 0) {
        stopTimer();
      } else {
        setState(() {
          myDuration--;
        });
      }
    });
  }

  void stopTimer() {
    setState(() {
      countdownTimer!.cancel();
    });
  }

  void resetTimer() {
    setState(() {
      stopTimer();
      myDuration = 16;
    });
    startTimer();
  }

  @override
  void dispose() {
    countdownTimer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xfff7f6fb),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios_new_outlined,
                    color: Color.fromARGB(255, 53, 86, 217),
                  ),
                ),
              ),
              Image.asset(
                'assets/img/verify.png',
                height: 250,
                width: 250,
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                'OTP VERIFICATION',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Enter Your Confirmation Code...',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black45,
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _textFieldOTP(first: true, last: false, context: context),
                  _textFieldOTP(first: false, last: false, context: context),
                  _textFieldOTP(first: false, last: false, context: context),
                  _textFieldOTP(first: false, last: true, context: context),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              if (myDuration > 0)
                Text(
                  "Timeout in ${myDuration.toString().padLeft(2, '0')}",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black45,
                  ),
                )
              else
                InkWell(
                  onTap: () {
                    resetTimer();
                  },
                  child: const Text(
                    'RESEND OTP',
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                    ),
                  ),
                ),
              const SizedBox(
                height: 35,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const BottomNavigation(
                            // selectedIndex: 0,
                            ),
                      ),
                      (route) => false);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    gradient: const LinearGradient(colors: [
                      Color.fromARGB(255, 50, 82, 223),
                      Color.fromARGB(255, 53, 86, 217),
                    ]),
                  ),
                  child: const Center(
                    child: Text(
                      'Verify',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _textFieldOTP({bool? first, last, context}) {
  return SizedBox(
    height: 85,
    child: AspectRatio(
      aspectRatio: 0.9,
      child: TextField(
        autofocus: false,
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
        showCursor: false,
        readOnly: false,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(
          counter: const Offstage(),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 2, color: Colors.black12),
              borderRadius: BorderRadius.circular(12)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 2,
                color: Color.fromARGB(255, 53, 86, 217),
              ),
              borderRadius: BorderRadius.circular(12)),
        ),
      ),
    ),
  );
}
