import 'package:task_1/src/model/login/login_model.dart';

abstract class SignInState {}

class SignInInitialState extends SignInState {}

class SignInLoadingState extends SignInState {}

class SignInLoadedState extends SignInState {
  final LoginModel model;

  SignInLoadedState({required this.model});
}

class SignInInvalidCredentials extends SignInState {}

class SignInErrorState extends SignInState {
  final String error;
  SignInErrorState({
    required this.error,
  });
}
