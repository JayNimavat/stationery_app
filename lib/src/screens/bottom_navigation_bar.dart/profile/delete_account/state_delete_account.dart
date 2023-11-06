import 'package:task_1/src/model/profile/delete_account_model.dart';

abstract class DeleteAccountState {}

class DeleteAccountInitialState extends DeleteAccountState {}

class DeleteAccountLoadingState extends DeleteAccountState {}

class DeleteAccountLoadedState extends DeleteAccountState {
  final DeleteAccountModel deleteAccount;

  DeleteAccountLoadedState({required this.deleteAccount});
}

class DeleteAccountErrorState extends DeleteAccountState {
  final String error;

  DeleteAccountErrorState({required this.error});
}
