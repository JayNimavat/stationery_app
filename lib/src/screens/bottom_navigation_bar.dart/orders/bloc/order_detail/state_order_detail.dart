import 'package:task_1/src/model/orders/order_detail_model.dart';

abstract class OrderDetailState {}

class OrderDetailInitialState extends OrderDetailState {}

class OrderDetailLoadingState extends OrderDetailState {}

class OrderDetailLoadedState extends OrderDetailState {
  OrderDetailModel orderDetailData;

  OrderDetailLoadedState({required this.orderDetailData});
}

class OrderDetailErrorState extends OrderDetailState {
  final String error;

  OrderDetailErrorState({required this.error});
}
