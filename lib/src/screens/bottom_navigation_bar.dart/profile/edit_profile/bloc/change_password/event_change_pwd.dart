abstract class ChangePwdEvent {}

class ChangePwdBtnEvent extends ChangePwdEvent {
  final String password;
  final String cnfPassword;

  ChangePwdBtnEvent({
    required this.password,
    required this.cnfPassword,
  });
}
