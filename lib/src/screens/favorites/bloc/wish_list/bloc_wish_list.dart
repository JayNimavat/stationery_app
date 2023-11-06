import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_1/src/model/favorites/wish_list_model.dart';
import 'package:task_1/src/screens/favorites/bloc/wish_list/event_wish_list.dart';
import 'package:task_1/src/screens/favorites/bloc/wish_list/state_wish_list.dart';
import 'package:http/http.dart' as http;
import 'package:task_1/src/server_url/base_app_url.dart';

class WishListBloc extends Bloc<WishListEvent, WishListState> {
  WishListBloc() : super(WishListInitialState()) {
    on<WishListDataEvent>((event, emit) async {
      emit(WishListLoadingState());
      try {
        WishListModel model = await fetchDataFromApi();
        if (model.status == 200) {
          emit(WishListLoadedState(wishListData: model));
        } else {
          emit(WishListErrorState(
              error: 'An error occurred while fetching data from API'));
        }
      } catch (error) {
        // print('Error during API request: $error');
        emit(WishListErrorState(
            error: 'An error occurred in FAVORITE LIST BLOC '));
      }
    });
  }

  fetchDataFromApi() async {
    WishListModel model;
    Map data = {
      'user_id': '12',
    };

    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}wishList";
    final Uri url = Uri.parse(apiUrl);
    final response = await http.post(url, body: data);

    model = WishListModel.fromJsonMap(json.decode(response.body));
    return model;
  }
}
