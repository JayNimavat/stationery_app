import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/orders/order_detail.dart';
import 'package:task_1/src/screens/cart/bloc/checkout/bloc_checkout.dart';
import 'package:task_1/src/screens/cart/bloc/checkout/event_checkout.dart';
import 'package:task_1/src/screens/cart/bloc/checkout/state_checkout.dart';

class OrderSuccess extends StatefulWidget {
  final String discountTotal;
  final String couponDiscount;
  final String totalAmount;
  const OrderSuccess({
    super.key,
    required this.discountTotal,
    required this.couponDiscount,
    required this.totalAmount,
  });

  @override
  State<OrderSuccess> createState() => _OrderSuccessState();
}

class _OrderSuccessState extends State<OrderSuccess> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CheckoutBloc>(
          create: (context) => CheckoutBloc(),
        ),
      ],
      child: OrderSuccessfully(
        couponDiscount: widget.couponDiscount,
        totalAmount: widget.totalAmount,
        discountTotal: widget.discountTotal,
      ),
    );
  }
}

class OrderSuccessfully extends StatefulWidget {
  final String discountTotal;
  final String couponDiscount;
  final String totalAmount;
  const OrderSuccessfully({
    super.key,
    required this.discountTotal,
    required this.couponDiscount,
    required this.totalAmount,
  });

  @override
  State<OrderSuccessfully> createState() => _OrderSuccessfullyState();
}

class _OrderSuccessfullyState extends State<OrderSuccessfully> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CheckoutBloc>(context).add(CheckoutBtnEvent(
      userAddressId:
          'Madhavbaug Vidhyabhavan, New Kosad Road, Amroli 394107. Mobile No: 9913514147',
      couponId: '5',
      paymentType: 'Pickup',
      totalDiscount: widget.couponDiscount,
      totalAmount: widget.totalAmount,
      offerDiscount: widget.discountTotal,
      transactionId: '',
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutBloc, CheckoutState>(
      builder: (context, state) {
        if (state is CheckoutLoadedState) {
          // print('ORDER SCREEN');
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: OrderDetailScreen(
              orderId: state.checkoutData.checkoutModelData.id.toString(),
              orderIDEncrypt:
                  state.checkoutData.checkoutModelData.orderIDEncrypt,
            ),
          );
        } else if (state is CheckoutErrorState) {
          return Center(
            child: Text(state.error),
          );
        }
        return Container();
      },
    );
  }
}
