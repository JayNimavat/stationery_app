abstract class OrderListEvent {}

class OrderListDataEvent extends OrderListEvent {
  final String orderType;

  OrderListDataEvent({required this.orderType});
}
