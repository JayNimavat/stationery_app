abstract class ProductDetailEvent {}

class ProductDetailDataEvent extends ProductDetailEvent {
  final String productId;

  ProductDetailDataEvent({required this.productId});
}
