import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_1/src/model/verify_otp/verify_otp_model.dart';
import 'package:task_1/src/screens/otp_screen/bloc/verify_otp/event_verify_otp.dart';
import 'package:task_1/src/screens/otp_screen/bloc/verify_otp/state_verify_otp.dart';
import 'package:task_1/src/server_url/base_app_url.dart';
import 'package:http/http.dart' as http;

class VerifyOtpBloc extends Bloc<VerifyOtpEvent, VerifyOtpState> {
  VerifyOtpBloc() : super(VerifyOtpInitialState()) {
    on<VerifyOtpBtnEvent>((event, emit) async {
      emit(VerifyOtpLoadingState());
      try {
        VerifyOtpModel model = await fetchDataFromApi(
          mobileOtp: event.mobileOtp,
          deviceToken: event.deviceToken,
          deviceType: event.deviceType,
        );
        if (model.status == 200) {
          emit(VerifyOtpLoadedState(verifyOtp: model));
        } else {
          emit(VerifyOtpErrorState(
              error: 'An error occurred while fetching data of VERIFY OTP'));
        }
      } catch (error) {
        // print('Error in VERIFY OTP BLOC:$error');
        emit(
            VerifyOtpErrorState(error: 'An error occurred in VERIFY OTP BLOC'));
      }
    });
  }

  fetchDataFromApi({
    required String mobileOtp,
    required String deviceToken,
    required String deviceType,
  }) async {
    VerifyOtpModel model;
    Map data = {
      'user_id': '12',
      'mobile_otp': mobileOtp,
      'device_token': deviceToken,
      'device_type': deviceType,
    };

    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}verifyOtp";
    final Uri url = Uri.parse(apiUrl);
    final response = await http.post(url, body: data);

    model = VerifyOtpModel.fromJsonMap(json.decode(response.body));
    return model;
  }
}
