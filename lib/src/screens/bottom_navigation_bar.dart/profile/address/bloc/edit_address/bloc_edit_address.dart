import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_1/src/model/profile/Address/edit_address_model.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/profile/address/bloc/edit_address/event_edit_address.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/profile/address/bloc/edit_address/state_edit_address.dart';
import 'package:task_1/src/server_url/base_app_url.dart';
import 'package:http/http.dart' as http;

class EditAddressBloc extends Bloc<EditAddressEvent, EditAddressState> {
  EditAddressBloc() : super(EditAddressInitialState()) {
    on<EditAddressDataEvent>((event, emit) async {
      emit(EditAddressLoadingState());
      try {
        EditAddressModel model = await fetchDataFromApi(
          addressId: event.addressId,
          address: event.address,
          country: event.country,
          state: event.state,
          city: event.city,
          pincode: event.pincode,
          isDefault: event.isDefault,
          mobileNo: event.mobileNo,
        );
        if (model.status == 200) {
          emit(EditAddressLoadedState(editAddressData: model));
        } else {
          emit(EditAddressErrorState(
              error: 'An error occurred while fetching data from API'));
        }
      } catch (error) {
        // print('Error in EDIT ADDRESS BLOC:$error');
        emit(EditAddressErrorState(
            error: 'An error occurred in EDIT ADDRESS BLOC'));
      }
    });
  }

  fetchDataFromApi({
    required String addressId,
    required String address,
    required String country,
    required String state,
    required String city,
    required String pincode,
    required String isDefault,
    required String mobileNo,
  }) async {
    EditAddressModel model;
    Map data = {
      'user_id': '12',
      'address_id': addressId,
      'address': address,
      'country': country,
      'state': state,
      'city': city,
      'pincode': pincode,
      'is_default': isDefault,
      'mobile_no': mobileNo,
    };

    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}editAddress";
    final Uri url = Uri.parse(apiUrl);
    final response = await http.post(url, body: data);

    model = EditAddressModel.fromJsonMap(json.decode(response.body));
    return model;
  }
}
