abstract class SignInEvent {}

class SignInBtnEvent extends SignInEvent {
  final String email;
  final String password;

  SignInBtnEvent({
    required this.email,
    required this.password,
  });
}
