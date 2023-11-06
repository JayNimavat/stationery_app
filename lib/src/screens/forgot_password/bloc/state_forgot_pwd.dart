import 'package:task_1/src/model/forgot_password/forgot_password_model.dart';

abstract class ForgotPwdState {}

class ForgotPwdInitialState extends ForgotPwdState {}

class ForgotPwdLoadingState extends ForgotPwdState {}

class ForgotPwdLoadedState extends ForgotPwdState {
  final ForgotPwdModel forgotPwd;

  ForgotPwdLoadedState({required this.forgotPwd});
}

class ForgotPwdErrorState extends ForgotPwdState {
  final String error;

  ForgotPwdErrorState({required this.error});
}
