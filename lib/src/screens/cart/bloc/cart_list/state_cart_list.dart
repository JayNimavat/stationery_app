import 'package:task_1/src/model/cart/cart_list_model.dart';

abstract class CartListState {}

class CartListInitialState extends CartListState {}

class CartListLoadingState extends CartListState {}

class CartListLoadedState extends CartListState {
  final CartListModel cartListData;

  CartListLoadedState({required this.cartListData});
}

// class UpdateQtyState extends CartListState {
//   final CartListModel cartListData;

//   UpdateQtyState({required this.cartListData});
// }

class CartListErrorState extends CartListState {
  final String error;

  CartListErrorState({required this.error});
}
