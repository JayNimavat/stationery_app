import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_1/src/model/profile/Address/address_list_model.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/profile/address/bloc/address_list/event_address_list.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/profile/address/bloc/address_list/state_address_list.dart';
import 'package:task_1/src/server_url/base_app_url.dart';
import 'package:http/http.dart' as http;

class AddressListBloc extends Bloc<AddressListEvent, AddressListState> {
  AddressListBloc() : super(AddressListInitialState()) {
    on<AddressListDataEvent>((event, emit) async {
      emit(AddressListLoadingState());
      try {
        AddressListModel model = await fetchDataFromApi();
        if (model.status == 200) {
          emit(AddressListLoadedState(addressListData: model));
        } else {
          emit(AddressListErrorState(
              error: 'An error occurred while fetching data from API'));
        }
      } catch (error) {
        // print('Error in ADDRESS LIST BLOC:$error');
        emit(AddressListErrorState(error: 'An error in ADDRESS LIST BLOC'));
      }
    });
  }

  fetchDataFromApi() async {
    AddressListModel model;
    Map data = {
      'user_id': '12',
    };

    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}addressList";
    final Uri url = Uri.parse(apiUrl);
    final response = await http.post(url, body: data);

    model = AddressListModel.fromJsonMap(json.decode(response.body));
    return model;
  }
}
