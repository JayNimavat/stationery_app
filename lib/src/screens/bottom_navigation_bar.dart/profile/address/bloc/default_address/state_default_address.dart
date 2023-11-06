import 'package:task_1/src/model/profile/Address/default_address_model.dart';

abstract class DefaultAddressState {}

class DefaultAddressInitialState extends DefaultAddressState {}

class DefaultAddressLoadingState extends DefaultAddressState {}

class DefaultAddressLoadedState extends DefaultAddressState {
  final DefaultAddressModel defaultAddressData;

  DefaultAddressLoadedState({required this.defaultAddressData});
}

class DefaultAddressErrorState extends DefaultAddressState {
  final String error;

  DefaultAddressErrorState({required this.error});
}
