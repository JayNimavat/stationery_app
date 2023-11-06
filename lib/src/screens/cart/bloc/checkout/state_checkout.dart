import 'package:task_1/src/model/cart/checkout_model.dart';

abstract class CheckoutState {}

class CheckoutInitialState extends CheckoutState {}

class CheckoutLoadingState extends CheckoutState {}

class CheckoutLoadedState extends CheckoutState {
  final CheckoutModel checkoutData;

  CheckoutLoadedState({required this.checkoutData});
}

class CheckoutErrorState extends CheckoutState {
  final String error;

  CheckoutErrorState({required this.error});
}
