import 'package:task_1/src/model/profile/change_password_model.dart';

abstract class ChangePwdState {}

class ChangePwdInitialState extends ChangePwdState {}

class ChangePwdLoadingState extends ChangePwdState {}

class ChangePwdLoadedState extends ChangePwdState {
  final ChangePasswordModel changePassword;

  ChangePwdLoadedState({required this.changePassword});
}

class ChangePwdErrorState extends ChangePwdState {
  final String error;

  ChangePwdErrorState({required this.error});
}
