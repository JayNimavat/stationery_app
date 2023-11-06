abstract class DefaultAddressEvent {}

class DefaultAddressDataEvent extends DefaultAddressEvent {
  final String addressId;
  final String isDefault;

  DefaultAddressDataEvent({
    required this.addressId,
    required this.isDefault,
  });
}
