class EditAddressModel {
  final int status;
  final EditAddressModelData editAddressModelData;
  final String message;

  EditAddressModel.fromJsonMap(Map<String, dynamic> map)
      : status = map['status'],
        editAddressModelData = EditAddressModelData.fromJsonMap(map['data']),
        message = map['message'];
}

class EditAddressModelData {
  final int id;
  final String userId;
  final String address;
  final String mobileNo;
  final String country;
  final String state;
  final String city;
  final String pincode;
  final String isDefault;
  final String createdAt;
  final String updatedAt;
  final String deletedAt;

  EditAddressModelData.fromJsonMap(Map<String, dynamic> map)
      : id = map['id'],
        userId = map['user_id'],
        address = map['address'],
        mobileNo = map['mobile_no'],
        country = map['country'],
        state = map['state'],
        city = map['city'],
        pincode = map['pincode'],
        isDefault = map['is_default'],
        createdAt = map['created_at'],
        updatedAt = map['updated_at'],
        deletedAt = map['deleted_at'];
}
