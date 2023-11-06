abstract class ResendOtpEvent {}

class ResendOtpBtnEvent extends ResendOtpEvent {
  final String deviceToken;
  final String deviceType;

  ResendOtpBtnEvent({
    required this.deviceToken,
    required this.deviceType,
  });
}
