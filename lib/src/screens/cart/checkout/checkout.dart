import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_1/src/screens/cart/bloc/cart_list/bloc_cart_list.dart';
import 'package:task_1/src/screens/cart/bloc/cart_list/event_cart_list.dart';
import 'package:task_1/src/screens/cart/bloc/checkout/bloc_checkout.dart';
import 'package:task_1/src/screens/cart/cart.dart';
import 'package:task_1/src/constants/colors.dart';
import 'package:task_1/src/screens/order_animation.dart';

class CheckoutScreen extends StatefulWidget {
  final String subTotal;
  final String discountTotal;
  final String couponDiscount;
  final String totalAmount;
  const CheckoutScreen({
    super.key,
    required this.totalAmount,
    required this.subTotal,
    required this.discountTotal,
    required this.couponDiscount,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CartListBloc>(
          create: (context) => CartListBloc(),
        ),
        BlocProvider<CheckoutBloc>(
          create: (context) => CheckoutBloc(),
        ),
      ],
      child: Checkout(
        totalAmount: widget.totalAmount,
        subTotal: widget.subTotal,
        discountTotal: widget.discountTotal,
        couponDiscount: widget.couponDiscount,
      ),
    );
  }
}

class Checkout extends StatefulWidget {
  final String subTotal;
  final String discountTotal;
  final String couponDiscount;
  final String totalAmount;
  const Checkout({
    super.key,
    required this.totalAmount,
    required this.subTotal,
    required this.discountTotal,
    required this.couponDiscount,
  });

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  String? address =
      'Madhavbaug Vidhyabhavan, New Kosad Road, Amroli 394107. Mobile No: 9913514147';
  String? payment;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CartListBloc>(context).add(CartListDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        toolbarHeight: 50,
        elevation: 0,
        title: const Text('Checkout'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orangeAccent, Colors.redAccent],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Pick up Address',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 1,
                height: 76,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    RadioListTile(
                      title: const Text(
                          "Madhavbaug Vidhyabhavan, New Kosad Road, Amroli 394107. Mobile No: 9913514147"),
                      value:
                          "Madhavbaug Vidhyabhavan, New Kosad Road, Amroli 394107. Mobile No: 9913514147",
                      groupValue: address,
                      onChanged: (value) {
                        setState(() {
                          address = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Payment Summary',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width - 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Total MRP',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              const Spacer(),
                              const Icon(
                                Icons.currency_rupee,
                                size: 15,
                              ),
                              Text(
                                widget.subTotal,
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Divider(thickness: 0.8),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              const Text(
                                'Discount on MRP',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              const Spacer(),
                              const Text(
                                '-',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 15,
                                ),
                              ),
                              const Icon(
                                Icons.currency_rupee,
                                size: 15,
                                color: Colors.green,
                              ),
                              Text(
                                widget.discountTotal,
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Divider(thickness: 0.8),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              const Text('Coupon Discount'),
                              const Spacer(),
                              const Text(
                                '-',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 15,
                                ),
                              ),
                              const Icon(
                                Icons.currency_rupee,
                                size: 15,
                                color: Colors.green,
                              ),
                              Text(
                                widget.couponDiscount,
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Divider(thickness: 0.8),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              const Text(
                                'Order Total',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Spacer(),
                              const Icon(
                                Icons.currency_rupee,
                                size: 15,
                              ),
                              Text(
                                widget.totalAmount,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Mode of Payment',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 1,
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    RadioListTile(
                      title: const Text("Cash on Pick Ups"),
                      value: "Pickup",
                      groupValue: payment,
                      onChanged: (value) {
                        setState(() {
                          payment = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Row(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 16,
            width: MediaQuery.of(context).size.width * 0.5,
            color: Colors.white,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop(
                  MaterialPageRoute(
                    builder: (context) => const CartScreen(),
                  ),
                );
              },
              child: const Center(
                child: Text('Cancel'),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 16,
            width: MediaQuery.of(context).size.width * 0.5,
            color: Colors.blue,
            child: InkWell(
              onTap: () {
                if (payment == null) {
                  // print('IF CONDITION');
                  _showToast('Please Select Payment Method');
                } else {
                  // print('ELSE CONDITION');
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SplashWidget(
                        couponDiscount: widget.couponDiscount,
                        discountTotal: widget.discountTotal,
                        totalAmount: widget.totalAmount,
                      ),
                    ),
                  );
                }
              },
              child: const Center(
                child: Text(
                  'Proceed Payment',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
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

void _showToast(String message) {
  // Show a toast message
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.black45,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
