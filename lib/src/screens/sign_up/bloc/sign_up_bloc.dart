import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:task_1/src/model/signup/signup_model.dart';
import 'package:task_1/src/screens/forgot_password/forgot_password.dart';
import 'package:task_1/src/screens/sign_up/bloc/sign_up_event.dart';
import 'package:task_1/src/screens/sign_up/bloc/sign_up_state.dart';
import 'package:task_1/src/server_url/base_app_url.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitialState()) {
    on<SignUpBtnEvent>((event, emit) async {
      emit(SignUpLoadingState());
      try {
        SignUpModel model = await signup(
          name: event.name,
          email: event.email,
          mobileNo: event.mobileNo,
          password: event.password,
          confirmPassword: event.confirmPassword,
        );
        if (model.status == 200) {
          showToastMessage(msg: model.message);
          emit(SignUpLoadedState(model: model));
        } else {
          showToastMessage(msg: model.message);
          emit(SignUpInvalidCredentials());
        }
      } catch (error) {
        emit(SignUpErrorState(error: "An error occured"));
      }
    });
  }

  signup({
    required String name,
    required String email,
    required String mobileNo,
    required String password,
    required String confirmPassword,
  }) async {
    SignUpModel model;
    Map data = {
      'name': name,
      'email': email,
      'mobile_no': mobileNo,
      'password': password,
      'confirm_password': confirmPassword,
    };
    final Uri url = Uri.parse("${SchoolEcommBaseAppUrl.baseAppUrl}signup");
    final response = await http.post(
      url,
      body: data,
    );
    model = SignUpModel.fromJsonMap(json.decode(response.body));
    return model;
  }
}
