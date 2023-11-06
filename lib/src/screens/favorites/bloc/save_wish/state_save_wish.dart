abstract class WishState {}

class WishInitialState extends WishState {}

class WishLoadingState extends WishState {}

class WishLoadedState extends WishState {
  final dynamic wishData;

  WishLoadedState({required this.wishData});
}

class RemoveWishLoadedState extends WishState {
  final dynamic wishData;

  RemoveWishLoadedState({required this.wishData});
}

class WishErrorState extends WishState {
  final String error;

  WishErrorState({required this.error});
}
