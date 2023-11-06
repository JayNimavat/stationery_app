import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:task_1/src/screens/order_successfully.dart';

class SplashWidget extends StatefulWidget {
  final String discountTotal;
  final String couponDiscount;
  final String totalAmount;
  const SplashWidget({
    super.key,
    required this.discountTotal,
    required this.couponDiscount,
    required this.totalAmount,
  });

  @override
  // ignore: library_private_types_in_public_api
  _SplashWidgetState createState() => _SplashWidgetState();
}

class _SplashWidgetState extends State<SplashWidget>
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
      duration: const Duration(milliseconds: 3400),
    )..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            Navigator.of(context).pop();
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => OrderSuccess(
                  couponDiscount: widget.couponDiscount,
                  totalAmount: widget.totalAmount,
                  discountTotal: widget.discountTotal,
                ),
              ),
            );
          }
        },
      );

    scaleAnimation =
        Tween<double>(begin: 0.0, end: 12).animate(scaleController);

    Timer(const Duration(milliseconds: 200), () {
      setState(() {
        _opacity = 1.0;
      });
    });
    Timer(const Duration(milliseconds: 3300), () {
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
      body: Stack(
        children: [
          Center(
            child: AnimatedOpacity(
              curve: Curves.easeOutCirc,
              duration: const Duration(milliseconds: 3400),
              opacity: _opacity,
              child: AnimatedContainer(
                curve: Curves.easeOutCirc,
                duration: const Duration(milliseconds: 3400),
                height: width / _containerSize,
                width: width / _containerSize,
                child: Center(
                  child: Column(
                    children: [
                      Lottie.asset(
                        'assets/order.json',
                        repeat: true,
                        reverse: true,
                        animate: true,
                      ),
                      const Text(
                        'Order Successfully',
                        style: TextStyle(
                          fontSize: 19,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
