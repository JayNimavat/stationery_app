import 'package:task_1/src/model/cart/apply_coupon_model.dart';

abstract class ApplyCouponState {}

class ApplyCouponInitialState extends ApplyCouponState {}

class ApplyCouponLoadingState extends ApplyCouponState {}

class ApplyCouponLoadedState extends ApplyCouponState {
  final ApplyCouponModel applyCouponData;

  ApplyCouponLoadedState({required this.applyCouponData});
}

class ApplyCouponErrorState extends ApplyCouponState {
  final String error;

  ApplyCouponErrorState({required this.error});
}
