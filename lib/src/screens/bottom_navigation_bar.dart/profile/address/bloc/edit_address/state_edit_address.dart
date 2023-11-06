import 'package:task_1/src/model/profile/Address/edit_address_model.dart';

abstract class EditAddressState {}

class EditAddressInitialState extends EditAddressState {}

class EditAddressLoadingState extends EditAddressState {}

class EditAddressLoadedState extends EditAddressState {
  final EditAddressModel editAddressData;

  EditAddressLoadedState({required this.editAddressData});
}

class EditAddressErrorState extends EditAddressState {
  final String error;

  EditAddressErrorState({required this.error});
}
