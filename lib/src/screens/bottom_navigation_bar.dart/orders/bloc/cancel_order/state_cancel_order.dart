import 'package:task_1/src/model/orders/cancel_order_model.dart';

abstract class CancelOrderState {}

class CancelOrderInitialState extends CancelOrderState {}

class CancelOrderLoadingState extends CancelOrderState {}

class CancelOrderLoadedState extends CancelOrderState {
  final CancelOrderModel cancelOrderData;

  CancelOrderLoadedState({required this.cancelOrderData});
}

class CancelOrderErrorState extends CancelOrderState {
  final String error;

  CancelOrderErrorState({required this.error});
}
