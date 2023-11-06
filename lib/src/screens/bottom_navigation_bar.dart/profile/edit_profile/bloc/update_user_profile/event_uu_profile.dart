abstract class UpdateUserProfileEvent {}

class UpdateUserProfileBtnEvent extends UpdateUserProfileEvent {
  final String name;
  final String mobileNo;
  final String email;
  // final String profileImage;

  UpdateUserProfileBtnEvent({
    required this.name,
    required this.mobileNo,
    required this.email,
    // required this.profileImage,
  });
}
