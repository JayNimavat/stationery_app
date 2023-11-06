abstract class RemoveAddressEvent {}

class RemoveAddressBtnEvent extends RemoveAddressEvent {
  final String id;

  RemoveAddressBtnEvent({required this.id});
}
