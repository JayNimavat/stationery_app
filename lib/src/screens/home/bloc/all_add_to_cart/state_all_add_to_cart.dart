import 'package:task_1/src/model/home/all_add_to_cart/all_add_to_cart_model.dart';

abstract class AllAddToCartState {}

class AllAddToCartInitialState extends AllAddToCartState {}

class AllAddToCartLoadingState extends AllAddToCartState {}

class AllAddToCartLoadedState extends AllAddToCartState {
  final AllAddToCartModel allAddToCartData;

  AllAddToCartLoadedState({required this.allAddToCartData});
}

class AllAddToCartErrorState extends AllAddToCartState {
  final String error;

  AllAddToCartErrorState({required this.error});
}
