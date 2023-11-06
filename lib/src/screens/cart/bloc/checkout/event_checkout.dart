abstract class CheckoutEvent {}

class CheckoutBtnEvent extends CheckoutEvent {
  final String userAddressId;
  final String couponId;
  final String paymentType;
  final String totalDiscount;
  final String totalAmount;
  final String offerDiscount;
  final String transactionId;

  CheckoutBtnEvent({
    required this.userAddressId,
    required this.couponId,
    required this.paymentType,
    required this.totalDiscount,
    required this.totalAmount,
    required this.offerDiscount,
    required this.transactionId,
  });
}
