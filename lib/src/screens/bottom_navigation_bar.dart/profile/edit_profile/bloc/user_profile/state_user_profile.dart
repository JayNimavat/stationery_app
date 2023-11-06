import 'package:task_1/src/model/user_profile/user_profile_model.dart';

abstract class UserProfileState {}

class UserProfileInitialState extends UserProfileState {}

class UserProfileLoadingState extends UserProfileState {}

class UserProfileLoadedState extends UserProfileState {
  final UserProfileModel userProfile;

  UserProfileLoadedState({required this.userProfile});
}

class UserProfileErrorState extends UserProfileState {
  final String error;

  UserProfileErrorState({required this.error});
}
