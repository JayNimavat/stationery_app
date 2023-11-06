abstract class CancelOrderEvent {}

class CancelOrderDataEvent extends CancelOrderEvent {
  final String cancelReason;
  final String orderId;

  CancelOrderDataEvent({
    required this.orderId,
    required this.cancelReason,
  });
}
