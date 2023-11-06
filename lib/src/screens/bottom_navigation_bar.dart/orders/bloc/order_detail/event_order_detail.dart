abstract class OrderDetailEvent {}

class OrderDetailBtnEvent extends OrderDetailEvent {
  final String orderId;
  final String orderIDEncrypt;

  OrderDetailBtnEvent({
    required this.orderId,
    required this.orderIDEncrypt,
  });
}
