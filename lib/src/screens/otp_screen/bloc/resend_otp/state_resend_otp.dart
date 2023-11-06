import 'package:task_1/src/model/resend_otp/resend_otp_model.dart';

abstract class ResendOtpState {}

class ResendOtpInitialState extends ResendOtpState {}

class ResendOtpLoadingState extends ResendOtpState {}

class ResendOtpLoadedState extends ResendOtpState {
  final ResendOtpModel resendOtp;

  ResendOtpLoadedState({required this.resendOtp});
}

class ResendOtpErrorState extends ResendOtpState {
  final String error;

  ResendOtpErrorState({required this.error});
}
