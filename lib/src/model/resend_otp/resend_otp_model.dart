class ResendOtpModel {
  final int status;
  final ResendOtpData resendOtpData;
  final String message;

  ResendOtpModel.fromJsonMap(Map<String, dynamic> map)
      : status = map['status'],
        resendOtpData = ResendOtpData.fromJsonMap(map['data']),
        message = map['message'];
}

class ResendOtpData {
  final int id;
  final String roleId;
  final String name;
  final String profileImage;
  final String email;
  final String mobileNo;
  final String emailOtp;
  final String status;
  final String deviceType;
  final String deviceToken;

  ResendOtpData.fromJsonMap(Map<String, dynamic> map)
      : id = map['id'],
        roleId = map['role_id'],
        name = map['name'],
        profileImage = map['profile_image'],
        email = map['email'],
        mobileNo = map['mobile_no'],
        emailOtp = map['email_otp'],
        status = map['status'],
        deviceType = map['device_type'],
        deviceToken = map['device_token'];
}
