abstract class AllAddToCartEvent {}

class AllAddToCartDataEvent extends AllAddToCartEvent {
  final String standardId;

  AllAddToCartDataEvent({
    required this.standardId,
  });
}
