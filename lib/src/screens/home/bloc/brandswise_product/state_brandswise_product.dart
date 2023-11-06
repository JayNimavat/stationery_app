import 'package:task_1/src/model/home/brandswise_product/brandswise_product_model.dart';

abstract class BrandswiseProductState {}

class BrandswiseProductInitialState extends BrandswiseProductState {}

class BrandswiseProductLoadingState extends BrandswiseProductState {}

class BrandswiseProductLoadedState extends BrandswiseProductState {
  final BrandswiseProductModel brandswiseProductData;

  BrandswiseProductLoadedState({required this.brandswiseProductData});
}

class BrandswiseProductErrorState extends BrandswiseProductState {
  final String error;

  BrandswiseProductErrorState({required this.error});
}
