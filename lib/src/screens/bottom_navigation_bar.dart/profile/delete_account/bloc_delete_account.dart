import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_1/src/model/profile/delete_account_model.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/profile/delete_account/event_delete_account.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/profile/delete_account/state_delete_account.dart';
import 'package:task_1/src/server_url/base_app_url.dart';
import 'package:http/http.dart' as http;

class DeleteAccountBloc extends Bloc<DeleteAccountEvent, DeleteAccountState> {
  DeleteAccountBloc() : super(DeleteAccountInitialState()) {
    on<DeleteAccountBtnEvent>((event, emit) async {
      emit(DeleteAccountLoadingState());
      try {
        DeleteAccountModel model = await fetchDataFromApi();
        if (model.status == 200) {
          emit(DeleteAccountLoadedState(deleteAccount: model));
        } else {
          emit(DeleteAccountErrorState(
              error: 'An error occurred while fetching data from API'));
        }
      } catch (error) {
        // print('Error in DELETE ACCOUNT BLOC:$error');
        emit(DeleteAccountErrorState(
            error: 'An error occurred in DELETE ACCOUNT BLOC'));
      }
    });
  }

  fetchDataFromApi() async {
    DeleteAccountModel model;
    Map data = {'user_id': '176'};

    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}deleteAccount";
    final Uri url = Uri.parse(apiUrl);
    final response = await http.post(url, body: data);

    model = DeleteAccountModel.fromJsonMap(json.decode(response.body));
    return model;
  }
}
