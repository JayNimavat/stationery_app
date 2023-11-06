import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_1/src/model/login/login_model.dart';
import 'package:task_1/src/screens/sign_in/bloc/sign_in_event.dart';
import 'package:task_1/src/screens/sign_in/bloc/sign_in_state.dart';
import 'package:task_1/src/screens/forgot_password/forgot_password.dart';
import 'package:task_1/src/server_url/base_app_url.dart';
import 'package:http/http.dart' as http;

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInInitialState()) {
    on<SignInBtnEvent>((event, emit) async {
      emit(SignInLoadingState());
      try {
        LoginModel model = await login(
          email: event.email,
          password: event.password,
        );
        if (model.status == 200) {
          showToastMessage(msg: model.message);
          emit(SignInLoadedState(model: model));
        } else {
          showToastMessage(msg: model.message);
          emit(SignInInvalidCredentials());
        }
      } catch (error) {
        emit(SignInErrorState(error: "An error occured"));
      }
      // if (event.email.isNotEmpty && event.password.isNotEmpty) {
      //   emit(SignInLoadingState());
      //   await Future.delayed(const Duration(milliseconds: 1000));
      //   // emit(SignInValidState());
      // } else if (event.email.isEmpty && event.password.isEmpty) {
      //   emit(showToastMessage(msg: 'Both Fields are Required'));
      // } else if (event.email.isEmpty) {
      //   emit(showToastMessage(msg: 'Email is Required'));
      // } else if (event.password.isEmpty) {
      //   emit(showToastMessage(msg: 'Password is Required'));
      // } else {
      //   // emit(SignInErrorState());
      // }
    });
  }

  login({required String email, required String password}) async {
    LoginModel model;
    Map data = {
      'mobile_and_email': email,
      'password': password,
    };
    final Uri url = Uri.parse("${SchoolEcommBaseAppUrl.baseAppUrl}login");
    final response = await http.post(
      url,
      body: data,
    );
    model = LoginModel.fromJsonMap(json.decode(response.body));
    return model;
  }
}
