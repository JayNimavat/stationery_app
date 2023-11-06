abstract class CartState {}

class CartInitialState extends CartState {}

class CartLoadingState extends CartState {}

class AddToCartLoadedState extends CartState {
  final dynamic cartData;

  AddToCartLoadedState({required this.cartData});
}

class RemoveCartLoadedState extends CartState {
  final dynamic cartData;

  RemoveCartLoadedState({required this.cartData});
}

class CartErrorState extends CartState {
  final String error;

  CartErrorState({required this.error});
}
