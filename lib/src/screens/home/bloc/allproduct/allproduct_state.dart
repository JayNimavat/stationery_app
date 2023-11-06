import 'package:task_1/src/model/home/allProducts/allproduct_model.dart';

abstract class AllproductState {}

class AllproductInitialState extends AllproductState {}

class AllproductLoadingState extends AllproductState {}

class AllproductLoadedState extends AllproductState {
  final AllproductModel productData;

  AllproductLoadedState({required this.productData});
}

class AllproductErrorState extends AllproductState {
  final String error;

  AllproductErrorState({required this.error});
}
