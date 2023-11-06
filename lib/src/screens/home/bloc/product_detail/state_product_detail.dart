import 'package:task_1/src/model/home/product_detail/product_detail_model.dart';

abstract class ProductDetailState {}

class ProductDetailInitialState extends ProductDetailState {}

class ProductDetailLoadingState extends ProductDetailState {}

class ProductDetailLoadedState extends ProductDetailState {
  final ProductDetailModel productDetailData;

  ProductDetailLoadedState({required this.productDetailData});
}

class ProductDetailErrorState extends ProductDetailState {
  final String error;

  ProductDetailErrorState({required this.error});
}
