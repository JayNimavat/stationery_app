abstract class BrandswiseProductEvent {}

class BrandswiseProductDataEvent extends BrandswiseProductEvent {
  final String brandId;

  BrandswiseProductDataEvent({required this.brandId});
}
