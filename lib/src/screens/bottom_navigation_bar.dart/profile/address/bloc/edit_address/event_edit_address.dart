abstract class EditAddressEvent {}

class EditAddressDataEvent extends EditAddressEvent {
  final String addressId;
  final String address;
  final String country;
  final String state;
  final String city;
  final String pincode;
  final String isDefault;
  final String mobileNo;

  EditAddressDataEvent({
    required this.addressId,
    required this.address,
    required this.country,
    required this.state,
    required this.city,
    required this.pincode,
    required this.isDefault,
    required this.mobileNo,
  });
}
