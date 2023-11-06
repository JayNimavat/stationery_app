import 'package:task_1/src/model/favorites/wish_list_model.dart';

abstract class WishListState {}

class WishListInitialState extends WishListState {}

class WishListLoadingState extends WishListState {}

class WishListLoadedState extends WishListState {
  final WishListModel wishListData;

  WishListLoadedState({required this.wishListData});
}

class WishListErrorState extends WishListState {
  final String error;

  WishListErrorState({required this.error});
}
