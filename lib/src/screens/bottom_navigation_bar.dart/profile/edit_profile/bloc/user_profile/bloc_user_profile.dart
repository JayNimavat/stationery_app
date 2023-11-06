import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_1/src/model/user_profile/user_profile_model.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/profile/edit_profile/bloc/user_profile/event_user_profile.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/profile/edit_profile/bloc/user_profile/state_user_profile.dart';
import 'package:task_1/src/server_url/base_app_url.dart';
import 'package:http/http.dart' as http;

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  UserProfileBloc() : super(UserProfileInitialState()) {
    on<UserProfileBtnEvent>((event, emit) async {
      try {
        UserProfileModel model = await fetchDataFromApi();
        if (model.status == 200) {
          emit(UserProfileLoadedState(userProfile: model));
        } else {
          emit(UserProfileErrorState(
              error: 'An error occurred while fetching data from API'));
        }
      } catch (error) {
        // print('Error in USER PROFILE BLOC:$error');
        emit(UserProfileErrorState(
            error: 'An error occurred in USER PROFILE BLOC'));
      }
    });
  }
  fetchDataFromApi() async {
    UserProfileModel model;
    Map data = {
      'user_id': '12',
    };

    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}userProfile";
    final Uri url = Uri.parse(apiUrl);
    final response = await http.post(url, body: data);

    model = UserProfileModel.fromJsonMap(json.decode(response.body));
    return model;
  }
}
