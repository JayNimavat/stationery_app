import 'package:task_1/src/model/home/brands/brands_model.dart';

abstract class BrandsState {}

class BrandsInitialState extends BrandsState {}

class BrandsLoadingState extends BrandsState {}

class BrandsLoadedState extends BrandsState {
  final BrandsModel brandsdata;

  BrandsLoadedState({required this.brandsdata});
}

class BrandsErrorState extends BrandsState {
  final String error;

  BrandsErrorState({required this.error});
}
