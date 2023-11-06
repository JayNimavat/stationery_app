import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/orders/bloc/order_list/bloc_order_list.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/orders/bloc/order_list/event_order_list.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/orders/bloc/order_list/state_order_list.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/orders/cancel_order_detail.dart';

class CancelledList extends StatefulWidget {
  const CancelledList({
    super.key,
  });

  @override
  State<CancelledList> createState() => _CancelledListState();
}

class _CancelledListState extends State<CancelledList> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<OrderListBloc>(
          create: (context) => OrderListBloc(),
        ),
      ],
      child: const CancelledData(),
    );
  }
}

class CancelledData extends StatefulWidget {
  const CancelledData({
    super.key,
  });

  @override
  State<CancelledData> createState() => _CancelledDataState();
}

class _CancelledDataState extends State<CancelledData> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<OrderListBloc>(context)
        .add(OrderListDataEvent(orderType: '5'));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderListBloc, OrderListState>(
      builder: (context, state) {
        if (state is OrderListLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is OrderListLoadedState) {
          return ListView.builder(
            itemCount: state.orderListData.orderListModelData.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(
                    left: 12, top: 10, right: 12, bottom: 10),
                padding: const EdgeInsets.all(10),
                height: 170,
                width: MediaQuery.of(context).size.width - 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade400,
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'Order: ',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: state.orderListData
                                    .orderListModelData[index].orderNo,
                                style: const TextStyle(
                                  color: Colors.black45,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          state.orderListData.orderListModelData[index]
                              .orderDate,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 17,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'Quantity: ',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: state.orderListData
                                    .orderListModelData[index].totalQuantity
                                    .toString(),
                                style: const TextStyle(
                                  color: Colors.black45,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        RichText(
                          text: TextSpan(
                            text: 'Total Amount: ',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: state.orderListData
                                    .orderListModelData[index].totalAmount,
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
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            elevation: 2,
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => CancelOrderDetail(
                                  orderId: state.orderListData
                                      .orderListModelData[index].id
                                      .toString(),
                                  orderIDEncrypt: state.orderListData
                                      .orderListModelData[index].orderIDEncrypt,
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            'Details',
                            style: TextStyle(color: Colors.cyan),
                          ),
                        ),
                        Text(
                          state.orderListData.orderListModelData[index]
                              .orderStatus,
                          style: TextStyle(
                            color: Colors.green[500],
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        } else if (state is OrderListErrorState) {
          return const Center(
            child: Text(
              'Cancelled Order Are Not Available',
              style: TextStyle(fontSize: 20, color: Colors.black87),
            ),
          );
        }
        return Container();
      },
    );
  }
}
