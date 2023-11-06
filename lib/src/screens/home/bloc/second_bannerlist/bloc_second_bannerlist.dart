import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_1/src/model/home/second_bannerlist/second_bannerlist.dart';
import 'package:task_1/src/screens/home/bloc/second_bannerlist/event_second_bannerlist.dart';
import 'package:task_1/src/screens/home/bloc/second_bannerlist/state_second_bannerlist.dart';
import 'package:task_1/src/server_url/base_app_url.dart';
import 'package:http/http.dart' as http;

class SecondBannerListBloc
    extends Bloc<SecondBannerListEvent, SecondBannerListState> {
  SecondBannerListBloc() : super(SecondBannerListInitialState()) {
    on<SecondBannerListDataEvent>((event, emit) async {
      emit(SecondBannerListLoadingState());
      try {
        SecondBannerListModel model = await fetchDataFromApi();
        if (model.status == 200) {
          emit(SecondBannerListLoadedState(secondBannerListData: model));
        } else {
          emit(SecondBannerListErrorState(
              error: 'An error occurred while fetching data from API'));
        }
      } catch (error) {
        emit(SecondBannerListErrorState(error: 'An error occurred'));
      }
    });
  }

  fetchDataFromApi() async {
    SecondBannerListModel model;
    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}secondBannerList";
    final Uri url = Uri.parse(apiUrl);
    final response = await http.post(url);

    model = SecondBannerListModel.fromJsonMap(json.decode(response.body));
    return model;
  }
}
