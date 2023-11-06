abstract class SignUpEvent {}

class SignUpBtnEvent extends SignUpEvent {
  final String name;
  final String email;
  final String mobileNo;
  final String password;
  final String confirmPassword;

  SignUpBtnEvent({
    required this.name,
    required this.email,
    required this.mobileNo,
    required this.password,
    required this.confirmPassword,
  });
}
