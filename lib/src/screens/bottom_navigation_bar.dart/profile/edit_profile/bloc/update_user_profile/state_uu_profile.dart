import 'package:task_1/src/model/profile/update_user_profile_model.dart';

abstract class UpdateUserProfileState {}

class UpdateUserProfileInitialState extends UpdateUserProfileState {}

class UpdateUserProfileLoadingState extends UpdateUserProfileState {}

class UpdateUserProfileLoadedState extends UpdateUserProfileState {
  final UpdateUserProfileModel updateUserProfile;

  UpdateUserProfileLoadedState({required this.updateUserProfile});
}

class UpdateUserProfileErrorState extends UpdateUserProfileState {
  final String error;

  UpdateUserProfileErrorState({required this.error});
}
