abstract class ApplyCouponEvent {}

class ApplyCouponBtnEvent extends ApplyCouponEvent {
  final String couponCode;

  ApplyCouponBtnEvent({required this.couponCode});
}
