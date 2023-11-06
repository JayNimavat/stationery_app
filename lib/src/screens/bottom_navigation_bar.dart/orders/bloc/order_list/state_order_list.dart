import 'package:task_1/src/model/orders/order_list_model.dart';

abstract class OrderListState {}

class OrderListInitialState extends OrderListState {}

class OrderListLoadingState extends OrderListState {}

class OrderListLoadedState extends OrderListState {
  final OrderListModel orderListData;

  OrderListLoadedState({required this.orderListData});
}

class OrderListErrorState extends OrderListState {
  final String error;

  OrderListErrorState({required this.error});
}
