import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_1/src/model/offer/offer_list_model.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/offers/bloc/offerlist_event.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/offers/bloc/offerlist_state.dart';
import 'package:task_1/src/server_url/base_app_url.dart';
import 'package:http/http.dart' as http;

class OfferListBloc extends Bloc<OfferListEvent, OfferListState> {
  OfferListBloc() : super(OfferListInitialState()) {
    on<OfferListDataEvent>((event, emit) async {
      emit(OfferListLoadingState());
      try {
        OfferListModel model = await fetchDataFromApi();
        if (model.status == 200) {
          emit(OfferListLoadedState(offerListData: model));
        } else {
          emit(OfferListErrorState(
              error: 'An error occurred while fetching data from API'));
        }
      } catch (error) {
        emit(
            OfferListErrorState(error: 'An error occurred in OFFER LIST DATA'));
      }
    });
  }

  fetchDataFromApi() async {
    OfferListModel model;
    Map data = {
      'user_id': '12',
    };
    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}offerList";
    final Uri url = Uri.parse(apiUrl);
    final response = await http.post(url, body: data);

    model = OfferListModel.fromJSonMap(json.decode(response.body));
    return model;
  }
}
