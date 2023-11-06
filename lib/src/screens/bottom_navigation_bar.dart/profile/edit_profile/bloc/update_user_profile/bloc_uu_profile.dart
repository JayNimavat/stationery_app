import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_1/src/model/profile/update_user_profile_model.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/profile/edit_profile/bloc/update_user_profile/event_uu_profile.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/profile/edit_profile/bloc/update_user_profile/state_uu_profile.dart';
import 'package:task_1/src/server_url/base_app_url.dart';
import 'package:http/http.dart' as http;

class UpdateUserProfileBloc
    extends Bloc<UpdateUserProfileEvent, UpdateUserProfileState> {
  UpdateUserProfileBloc() : super(UpdateUserProfileInitialState()) {
    on<UpdateUserProfileBtnEvent>((event, emit) async {
      emit(UpdateUserProfileLoadingState());
      try {
        UpdateUserProfileModel model = await fetchDataFromApi(
          name: event.name,
          mobileNo: event.mobileNo,
          email: event.email,
          // profileImage: event.profileImage,
        );
        if (model.status == 200) {
          emit(UpdateUserProfileLoadedState(updateUserProfile: model));
        } else {
          emit(UpdateUserProfileErrorState(
              error: 'An error occurred while fetching data from API'));
        }
      } catch (error) {
        // print('Error in UPDATE USER PROFILE BLOC:$error');
        emit(UpdateUserProfileErrorState(
            error: 'An error occurred in UPDATE USER PROFILE BLOC'));
      }
    });
  }

  fetchDataFromApi({
    required String name,
    required String mobileNo,
    required String email,
    // required String profileImage,
  }) async {
    UpdateUserProfileModel model;
    Map data = {
      'user_id': '12',
      'name': name,
      'mobile_no': mobileNo,
      'email': email,
      // 'profile_image': profileImage,
    };

    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}updateUserProfile";
    final Uri url = Uri.parse(apiUrl);
    final response = await http.post(url, body: data);

    model = UpdateUserProfileModel.fromJsonMap(json.decode(response.body));
    return model;
  }
}
