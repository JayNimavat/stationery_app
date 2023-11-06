class VerifyOtpModel {
  final int status;
  final VerifyOtpData verifyOtpData;
  final String message;

  VerifyOtpModel.fromJsonMap(Map<String, dynamic> map)
      : status = map['status'],
        verifyOtpData = VerifyOtpData.fromJsonMap(map['data']),
        message = map['message'];
}

class VerifyOtpData {
  final int id;
  final String roleId;
  final String name;
  final String profileImage;
  final String email;
  final String mobileNo;
  final String emailOtp;
  final String mobileOtp;
  final String status;
  final String deviceType;
  final String deviceToken;

  VerifyOtpData.fromJsonMap(Map<String, dynamic> map)
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
        deviceToken = map['device_token'];
}
