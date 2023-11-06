import 'package:task_1/src/model/profile/Address/address_list_model.dart';

abstract class AddressListState {}

class AddressListInitialState extends AddressListState {}

class AddressListLoadingState extends AddressListState {}

class AddressListLoadedState extends AddressListState {
  final AddressListModel addressListData;

  AddressListLoadedState({required this.addressListData});
}

class AddressListErrorState extends AddressListState {
  final String error;

  AddressListErrorState({required this.error});
}
