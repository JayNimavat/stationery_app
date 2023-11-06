import 'package:task_1/src/model/home/product_categorywise/categorywise_product_model.dart';

abstract class CatwiseProductState {}

class CatwiseProductInitialState extends CatwiseProductState {}

class CatwiseProductLoadingState extends CatwiseProductState {}

class CatwiseProductLoadedState extends CatwiseProductState {
  final CatwiseProductModel catwiseProductData;

  CatwiseProductLoadedState({required this.catwiseProductData});
}

class CatwiseProductErrorState extends CatwiseProductState {
  final String error;

  CatwiseProductErrorState({required this.error});
}
