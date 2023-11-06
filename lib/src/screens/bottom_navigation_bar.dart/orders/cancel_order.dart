import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/bottom_navigation.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/orders/bloc/cancel_order/bloc_cancel_order.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/orders/bloc/cancel_order/event_cancel_order.dart';

class CancelOrder extends StatefulWidget {
  final String orderId;

  const CancelOrder({
    super.key,
    required this.orderId,
  });

  @override
  State<CancelOrder> createState() => _CancelOrderState();
}

class _CancelOrderState extends State<CancelOrder> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CancelOrderBloc>(
          create: (context) => CancelOrderBloc(),
        ),
      ],
      child: Order(
        orderId: widget.orderId,
      ),
    );
  }
}

class Order extends StatefulWidget {
  final String orderId;

  const Order({
    super.key,
    required this.orderId,
  });

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  String? cancel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: 12,
          top: 100,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Reason for Cancellation',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const SizedBox(
              width: 390,
              child: Text(
                'Please tell the correct reason for cancellation.This information is only used to improve our service.',
                style: TextStyle(
                  fontSize: 14.8,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.all(9.0),
              child: Divider(
                thickness: 1.3,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            RichText(
              text: const TextSpan(
                text: 'Select Reason',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 19,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: '*',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            RadioListTile(
              title: const Text('Product not required anymore'),
              value: 'Product not required anymore',
              groupValue: cancel,
              onChanged: (value) {
                setState(() {
                  cancel = value;
                });
              },
            ),
            RadioListTile(
              title: const Text('Cash issue'),
              value: 'Cash issue',
              groupValue: cancel,
              onChanged: (value) {
                setState(() {
                  cancel = value;
                });
              },
            ),
            RadioListTile(
              title: const Text('Order by mistake'),
              value: 'Order by mistake',
              groupValue: cancel,
              onChanged: (value) {
                setState(() {
                  cancel = value;
                });
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 35,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    height: 45,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.blue),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 20,
                        ),
                        Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: () {
                    if (cancel == null) {
                      _showToast('Please select a reason');
                    } else {
                      BlocProvider.of<CancelOrderBloc>(context).add(
                        CancelOrderDataEvent(
                          cancelReason: cancel!,
                          orderId: widget.orderId,
                        ),
                      );
                      // print('CANCEL REASON:$cancel');

                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const BottomNavigation(),
                          ),
                          (route) => false);
                    }
                  },
                  child: Container(
                    height: 45,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.blue),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Ok',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
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
