import 'package:task_1/src/model/cart/add_to_cart_model.dart';
import 'package:task_1/src/model/cart/remove_cart_model.dart';

abstract class CartState {}

class CartInitialState extends CartState {}

class CartLoadingState extends CartState {}

class AddToCartLoadedState extends CartState {
  final AddToCartModel cartData;

  AddToCartLoadedState({required this.cartData});
}

class RemoveCartLoadedState extends CartState {
  final RemoveCartModel cartData;

  RemoveCartLoadedState({required this.cartData});
}

class CartErrorState extends CartState {
  final String error;

  CartErrorState({required this.error});
}
