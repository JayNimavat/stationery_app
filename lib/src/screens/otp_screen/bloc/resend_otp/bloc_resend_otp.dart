import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_1/src/model/resend_otp/resend_otp_model.dart';
import 'package:task_1/src/screens/otp_screen/bloc/resend_otp/event_resend_otp.dart';
import 'package:task_1/src/screens/otp_screen/bloc/resend_otp/state_resend_otp.dart';
import 'package:task_1/src/server_url/base_app_url.dart';
import 'package:http/http.dart' as http;

class ResendOtpBloc extends Bloc<ResendOtpEvent, ResendOtpState> {
  ResendOtpBloc() : super(ResendOtpInitialState()) {
    on<ResendOtpBtnEvent>((event, emit) async {
      emit(ResendOtpLoadingState());
      try {
        ResendOtpModel model = await fetchDataFromApi(
          deviceToken: event.deviceToken,
          deviceType: event.deviceType,
        );
        if (model.status == 200) {
          emit(ResendOtpLoadedState(resendOtp: model));
        } else {
          emit(ResendOtpErrorState(
              error: 'An error occurred while fetching data from RESEND OTP'));
        }
      } catch (error) {
        // print('Error in RESENED OTP BLOC: $error');
        emit(ResendOtpErrorState(
            error: 'An error occurred in RESENED OTP BLOC'));
      }
    });
  }

  fetchDataFromApi({
    required String deviceToken,
    required String deviceType,
  }) async {
    ResendOtpModel model;
    Map data = {
      'user_id': '12',
      'device_token': deviceToken,
      'device_type': deviceType,
    };

    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}resendOtp";
    final Uri url = Uri.parse(apiUrl);
    final response = await http.post(url, body: data);

    model = ResendOtpModel.fromJsonMap(json.decode(response.body));
    return model;
  }
}
