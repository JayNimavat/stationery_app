import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_1/src/constants/colors.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/orders/bloc/order_detail/bloc_order_detail.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/orders/bloc/order_detail/event_order_detail.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/orders/bloc/order_detail/state_order_detail.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/orders/cancel_order.dart';
import 'package:task_1/src/screens/home/bloc/home_count/bloc_home_count.dart';
import 'package:task_1/src/screens/home/bloc/home_count/event_home_count.dart';
import 'package:task_1/src/screens/home/products/products_screen.dart';
import 'package:easy_stepper/easy_stepper.dart';

class OrderDetailScreen extends StatefulWidget {
  final String orderId;
  final String orderIDEncrypt;

  const OrderDetailScreen({
    super.key,
    required this.orderId,
    required this.orderIDEncrypt,
  });

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCountBloc>(
          create: (context) => HomeCountBloc(),
        ),
        BlocProvider<OrderDetailBloc>(
          create: (context) => OrderDetailBloc(),
        ),
      ],
      child: OrderDetail(
        orderId: widget.orderId,
        orderIDEncrypt: widget.orderIDEncrypt,
      ),
    );
  }
}

class OrderDetail extends StatefulWidget {
  final String orderId;
  final String orderIDEncrypt;

  const OrderDetail({
    super.key,
    required this.orderId,
    required this.orderIDEncrypt,
  });

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {

  int activeStep = 1;

  final dashImages = [
    const Icon(Icons.list),
    const Icon(Icons.done),
    const Icon(Icons.directions_bike_outlined),
    const Icon(Icons.thumb_up_alt),
  ];
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeCountBloc>(context).add(HomeCountBtnEvent());
    BlocProvider.of<OrderDetailBloc>(context).add(OrderDetailBtnEvent(
      orderId: widget.orderId,
      orderIDEncrypt: widget.orderIDEncrypt,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        toolbarHeight: 50,
        elevation: 0,
        title: const Text('Order Details'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orangeAccent, Colors.redAccent],
            ),
          ),
        ),
      ),
      body: BlocBuilder<OrderDetailBloc, OrderDetailState>(
        builder: (context, state) {
          if (state is OrderDetailLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is OrderDetailLoadedState) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(9),
                child: Column(
                  //  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Pending',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    EasyStepper(
                      activeStep: activeStep,
                      lineLength: 38,
                      stepShape: StepShape.circle,
                      stepBorderRadius: 15,
                      borderThickness: 2,
                      stepRadius: 23,
                      finishedStepBorderColor: Colors.blue,
                      finishedStepTextColor: Colors.blue,
                      finishedStepBackgroundColor: Colors.blue,
                      showLoadingAnimation: true,
                      steps: const [
                        EasyStep(
                          icon: Icon(Icons.list),
                          title: 'Pending',
                        ),
                        EasyStep(
                          icon: Icon(Icons.done),
                          title: 'Confirmed',
                        ),
                        EasyStep(
                          icon: Icon(Icons.directions_bike_outlined),
                          title: 'Ready',
                        ),
                        EasyStep(
                          icon: Icon(Icons.thumb_up),
                          title: 'Delivered',
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      height: 287,
                      width: MediaQuery.of(context).size.width - 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: 'Order: ',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: state
                                          .orderDetailData
                                          .orderDetailModelData
                                          .orderDetail
                                          .orderNo,
                                      style: const TextStyle(
                                        color: Colors.black45,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                state.orderDetailData.orderDetailModelData
                                    .orderDetail.orderDate,
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 23,
                          ),
                          RichText(
                            text: TextSpan(
                              text: 'Payment Type: ',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: state
                                      .orderDetailData
                                      .orderDetailModelData
                                      .orderDetail
                                      .paymentType,
                                  style: const TextStyle(
                                    color: Colors.black45,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: 'Pick up date: ',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: state
                                          .orderDetailData
                                          .orderDetailModelData
                                          .orderDetail
                                          .pickupDate,
                                      style: const TextStyle(
                                        color: Colors.black45,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  elevation: 2,
                                ),
                                onPressed: () {},
                                child: const Text(
                                  'Invoice',
                                  style: TextStyle(color: Colors.cyan),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: 'Total Amount: ',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: state
                                          .orderDetailData
                                          .orderDetailModelData
                                          .orderDetail
                                          .totalAmount,
                                      style: const TextStyle(
                                        color: Colors.cyan,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              const Text(
                                'INR',
                                style: TextStyle(
                                  color: Colors.cyan,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          RichText(
                            text: TextSpan(
                              text: 'Pick up Location: \n',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: state
                                      .orderDetailData
                                      .orderDetailModelData
                                      .orderDetail
                                      .userAddressId,
                                  style: const TextStyle(
                                    color: Colors.black45,
                                  ),
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
                    ListView.builder(
                      itemCount: state.orderDetailData.orderDetailModelData
                          .orderDetail.orderItem.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(
                              left: 9, top: 7, right: 9, bottom: 7),
                          padding: const EdgeInsets.all(9),
                          height: 83,
                          width: MediaQuery.of(context).size.width - 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Row(
                            //  crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                state
                                    .orderDetailData
                                    .orderDetailModelData
                                    .orderDetail
                                    .orderItem[index]
                                    .productData
                                    .productImage,
                                height: 60,
                                width: 70,
                                fit: BoxFit.fill,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state
                                                .orderDetailData
                                                .orderDetailModelData
                                                .orderDetail
                                                .orderItem[index]
                                                .productData
                                                .productName
                                                .length >
                                            18
                                        ? '${state.orderDetailData.orderDetailModelData.orderDetail.orderItem[index].productData.productName.substring(0, 18)}...'
                                        : state
                                            .orderDetailData
                                            .orderDetailModelData
                                            .orderDetail
                                            .orderItem[index]
                                            .productData
                                            .productName,
                                    style: const TextStyle(
                                      color: Colors.black45,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.currency_rupee_outlined,
                                        size: 15,
                                        color: Colors.blue,
                                      ),
                                      Text(
                                        state
                                            .orderDetailData
                                            .orderDetailModelData
                                            .orderDetail
                                            .orderItem[index]
                                            .productData
                                            .discountPrice,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.blue),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Align(
                                alignment: Alignment.topRight,
                                child: RichText(
                                  text: TextSpan(
                                    text: 'x',
                                    style: const TextStyle(
                                      color: Colors.black45,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: state
                                            .orderDetailData
                                            .orderDetailModelData
                                            .orderDetail
                                            .orderItem[index]
                                            .quantity,
                                        style: const TextStyle(
                                          color: Colors.black45,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Payment Summary',
                        style: TextStyle(
                          fontSize: 15,
                        ),
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
                                      Icons.currency_rupee_outlined,
                                      size: 15,
                                      color: Colors.black,
                                    ),
                                    Text(
                                      state.orderDetailData.orderDetailModelData
                                          .orderDetail.subTotal
                                          .toString(),
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
                                      Icons.currency_rupee_outlined,
                                      size: 15,
                                      color: Colors.green,
                                    ),
                                    Text(
                                      state.orderDetailData.orderDetailModelData
                                          .orderDetail.discountMRP
                                          .toString(),
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
                                      Icons.currency_rupee_outlined,
                                      size: 15,
                                      color: Colors.green,
                                    ),
                                    Text(
                                      state.orderDetailData.orderDetailModelData
                                          .orderDetail.totalDiscount,
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
                                      Icons.currency_rupee_outlined,
                                      size: 15,
                                      color: Colors.black,
                                    ),
                                    Text(
                                      state.orderDetailData.orderDetailModelData
                                          .orderDetail.totalAmount,
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
                  ],
                ),
              ),
            );
          } else if (state is OrderDetailErrorState) {
            return Center(
              child: Text(state.error),
            );
          }
          return Container();
        },
      ),
      bottomNavigationBar: Row(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 16,
            width: MediaQuery.of(context).size.width * 0.5,
            color: Colors.white,
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CancelOrder(
                      orderId: widget.orderId,
                    ),
                  ),
                );
              },
              child: const Center(
                child: Text('Cancel Order'),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 16,
            width: MediaQuery.of(context).size.width * 0.5,
            color: Colors.blue,
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ProductsWidget(),
                  ),
                );
              },
              child: const Center(
                child: Text(
                  'View More',
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
