import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_1/src/model/profile/change_password_model.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/profile/edit_profile/bloc/change_password/event_change_pwd.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/profile/edit_profile/bloc/change_password/state_change_pwd.dart';
import 'package:task_1/src/server_url/base_app_url.dart';
import 'package:http/http.dart' as http;

class ChangePwdBloc extends Bloc<ChangePwdEvent, ChangePwdState> {
  ChangePwdBloc() : super(ChangePwdInitialState()) {
    on<ChangePwdBtnEvent>((event, emit) async {
      emit(ChangePwdLoadingState());
      try {
        ChangePasswordModel model = await fetchDataFromApi(
            password: event.password, cnfPassword: event.cnfPassword);
        if (model.status == 200) {
          emit(ChangePwdLoadedState(changePassword: model));
        } else {
          emit(ChangePwdErrorState(
              error: 'An error occurred while fetching data from API'));
        }
      } catch (error) {
        // print('Error in CHANGE PWD BLOC:$error');
        emit(
            ChangePwdErrorState(error: 'An error occurred in CHANGE PWD BLOC'));
      }
    });
  }

  fetchDataFromApi(
      {required String password, required String cnfPassword}) async {
    ChangePasswordModel model;
    Map data = {
      'user_id': '12',
      'password': password,
      're_enter_password': cnfPassword,
    };

    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}changePassword";
    final Uri url = Uri.parse(apiUrl);
    final response = await http.post(url, body: data);

    model = ChangePasswordModel.fromJsonMap(json.decode(response.body));
    return model;
  }
}
