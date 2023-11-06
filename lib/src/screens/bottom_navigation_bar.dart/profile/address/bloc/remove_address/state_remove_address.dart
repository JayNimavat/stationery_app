import 'package:task_1/src/model/profile/Address/remove_address_model.dart';

abstract class RemoveAddressState {}

class RemoveAddressInitialState extends RemoveAddressState {}

class RemoveAddressLoadingState extends RemoveAddressState {}

class RemoveAddressLoadedState extends RemoveAddressState {
  final RemoveAddressModel removeAddressData;

  RemoveAddressLoadedState({required this.removeAddressData});
}

class RemoveAddressErrorState extends RemoveAddressState {
  final String error;

  RemoveAddressErrorState({required this.error});
}
