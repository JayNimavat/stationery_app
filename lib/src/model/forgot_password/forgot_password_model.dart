class ForgotPwdModel {
  final int status;
  final ForgotPwdModelData forgotPwdData;
  final String message;

  ForgotPwdModel.fromJsonMap(Map<String, dynamic> map)
      : status = map['status'],
        forgotPwdData = ForgotPwdModelData.fromJsonMap(map['data']),
        message = map['message'];
}

class ForgotPwdModelData {
  final int id;
  final String roleId;
  final String name;
  final String profileImage;
  final String email;
  final String mobileNo;
  final String emailOtp;
  final int mobileOtp;
  final String status;
  final String deviceType;
  final String deviceToken;
  final String deletedAt;
  final String createdAt;
  final String updatedAt;

  ForgotPwdModelData.fromJsonMap(Map<String, dynamic> map)
      : id = map['id'],
        roleId = map['role_id'],
        name = map['name'],
        profileImage = map['profile_image'],
        email = map['email'],
        mobileNo = map['mobile_no'],
        emailOtp = map['email_otp'],
        mobileOtp = map['mobile_otp'],
        status = map['status'],
        deviceType = map['device_type'],
        deviceToken = map['device_token'],
        deletedAt = map['deleted_at'],
        createdAt = map['created_at'],
        updatedAt = map['updated_at'];
}
