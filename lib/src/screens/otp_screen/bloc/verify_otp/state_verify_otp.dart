import 'package:task_1/src/model/verify_otp/verify_otp_model.dart';

abstract class VerifyOtpState {}

class VerifyOtpInitialState extends VerifyOtpState {}

class VerifyOtpLoadingState extends VerifyOtpState {}

class VerifyOtpLoadedState extends VerifyOtpState {
  VerifyOtpModel verifyOtp;

  VerifyOtpLoadedState({required this.verifyOtp});
}

class VerifyOtpInvalidState extends VerifyOtpState {}

class VerifyOtpErrorState extends VerifyOtpState {
  final String error;

  VerifyOtpErrorState({required this.error});
}
