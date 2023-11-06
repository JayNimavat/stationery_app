import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_1/src/model/profile/Address/remove_address_model.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/profile/address/bloc/remove_address/event_remove_address.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/profile/address/bloc/remove_address/state_remove_address.dart';
import 'package:task_1/src/server_url/base_app_url.dart';
import 'package:http/http.dart' as http;

class RemoveAddressBloc extends Bloc<RemoveAddressEvent, RemoveAddressState> {
  RemoveAddressBloc() : super(RemoveAddressInitialState()) {
    on<RemoveAddressBtnEvent>((event, emit) async {
      emit(RemoveAddressLoadingState());
      try {
        RemoveAddressModel model = await fetchDataFromApi(id: event.id);
        if (model.status == 200) {
          emit(RemoveAddressLoadedState(removeAddressData: model));
        } else {
          emit(RemoveAddressErrorState(
              error: 'An error occurred while fetching data from API'));
        }
      } catch (error) {
        // print('Error in REMOVE ADDRESS BLOC:$error');
        emit(RemoveAddressErrorState(
            error: 'An error occurred in REMOVE ADDRESS BLOC'));
      }
    });
  }

  fetchDataFromApi({required String id}) async {
    RemoveAddressModel model;
    Map data = {
      'user_id': '12',
      'address_id': id,
    };

    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}removeAddress";
    final Uri url = Uri.parse(apiUrl);
    final response = await http.post(url, body: data);

    model = RemoveAddressModel.fromJsonMap(json.decode(response.body));
    return model;
  }
}
