abstract class CartEvent {}

class AddToCartEvent extends CartEvent {
  final String productId;
  final String qty;

  AddToCartEvent({required this.productId, required this.qty});
}

class RemoveCartEvent extends CartEvent {
  final String productId;

  RemoveCartEvent({
    required this.productId,
  });
}
