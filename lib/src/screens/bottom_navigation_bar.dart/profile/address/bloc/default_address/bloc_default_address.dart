import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_1/src/model/profile/Address/default_address_model.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/profile/address/bloc/default_address/event_default_address.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/profile/address/bloc/default_address/state_default_address.dart';
import 'package:task_1/src/server_url/base_app_url.dart';
import 'package:http/http.dart' as http;

class DefaultAddressBloc
    extends Bloc<DefaultAddressEvent, DefaultAddressState> {
  DefaultAddressBloc() : super(DefaultAddressInitialState()) {
    on<DefaultAddressDataEvent>((event, emit) async {
      emit(DefaultAddressLoadingState());
      try {
        DefaultAddressModel model = await fetchDataFromApi(
          addressId: event.addressId,
          isDefault: event.isDefault,
        );
        if (model.status == 200) {
          emit(DefaultAddressLoadedState(defaultAddressData: model));
        } else {
          emit(DefaultAddressErrorState(
              error: 'An error occurred while fetching data from API'));
        }
      } catch (error) {
        // print('Error in DEFAULT ADDRESS BLOC:$error');
        emit(DefaultAddressErrorState(
            error: 'An error occurred in DEFAULT ADDRESS BLOC'));
      }
    });
  }

  fetchDataFromApi({
    required String addressId,
    required String isDefault,
  }) async {
    DefaultAddressModel model;
    Map data = {
      'user_id': '12',
      'address_id': addressId,
      'is_default': isDefault,
    };

    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}defaultAddress";
    final Uri url = Uri.parse(apiUrl);
    final response = await http.post(url, body: data);

    model = DefaultAddressModel.fromJsonMap(json.decode(response.body));
    return model;
  }
}
