abstract class WishEvent {}

class SaveWishDataEvent extends WishEvent {
  final String productId;

  SaveWishDataEvent({required this.productId});
}

class RemoveWishEvent extends WishEvent {
  final String wishlistId;

  RemoveWishEvent({required this.wishlistId});
}
