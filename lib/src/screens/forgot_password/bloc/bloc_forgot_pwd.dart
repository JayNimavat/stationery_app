import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_1/src/model/forgot_password/forgot_password_model.dart';
import 'package:task_1/src/screens/forgot_password/bloc/event_forgot_pwd.dart';
import 'package:task_1/src/screens/forgot_password/bloc/state_forgot_pwd.dart';
import 'package:task_1/src/server_url/base_app_url.dart';
import 'package:http/http.dart' as http;

class ForgotPwdBloc extends Bloc<ForgotPwdEvent, ForgotPwdState> {
  ForgotPwdBloc() : super(ForgotPwdInitialState()) {
    on<ForgotPwdBtnEvent>((event, emit) async {
      emit(ForgotPwdLoadingState());
      try {
        ForgotPwdModel model = await fetchDataFromApi(mobileNo: event.mobileNo);
        if (model.status == 200) {
          emit(ForgotPwdLoadedState(forgotPwd: model));
        } else {
          emit(ForgotPwdErrorState(
              error: 'An error occurred while fetching data from API'));
        }
      } catch (error) {
        // print('Error in FORGOT PWD BLOC:$error');
        emit(
            ForgotPwdErrorState(error: 'An error occurred in FORGOT PWD BLOC'));
      }
    });
  }

  fetchDataFromApi({required String mobileNo}) async {
    ForgotPwdModel model;
    Map data = {
      'mobile_and_email': mobileNo,
    };

    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}forgotPassword";
    final Uri url = Uri.parse(apiUrl);
    final response = await http.post(url, body: data);

    model = ForgotPwdModel.fromJsonMap(json.decode(response.body));
    return model;
  }
}
