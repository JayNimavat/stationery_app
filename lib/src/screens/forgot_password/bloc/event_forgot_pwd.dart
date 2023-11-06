abstract class ForgotPwdEvent {}

class ForgotPwdBtnEvent extends ForgotPwdEvent {
  final String mobileNo;

  ForgotPwdBtnEvent({required this.mobileNo});
}
