abstract class VerifyOtpEvent {}

class VerifyOtpBtnEvent extends VerifyOtpEvent {
  final String mobileOtp;
  final String deviceToken;
  final String deviceType;

  VerifyOtpBtnEvent({
    required this.mobileOtp,
    required this.deviceToken,
    required this.deviceType,
  });
}
