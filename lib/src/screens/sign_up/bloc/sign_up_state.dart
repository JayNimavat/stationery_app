import 'package:task_1/src/model/signup/signup_model.dart';

abstract class SignUpState {}

class SignUpInitialState extends SignUpState {}

class SignUpLoadingState extends SignUpState {}

class SignUpLoadedState extends SignUpState {
  final SignUpModel model;

  SignUpLoadedState({required this.model});
}

class SignUpInvalidCredentials extends SignUpState {}

class SignUpErrorState extends SignUpState {
  final String error;

  SignUpErrorState({required this.error});
}
