import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_1/src/model/home/today_deal/todaydeal_model.dart';
import 'package:task_1/src/screens/home/bloc/today_deal/todaydeal_event.dart';
import 'package:task_1/src/screens/home/bloc/today_deal/todaydeal_state.dart';
import 'package:task_1/src/server_url/base_app_url.dart';
import 'package:http/http.dart' as http;

class TodaydealBloc extends Bloc<TodaydealEvent, TodaydealState> {
  TodaydealBloc() : super(TodaydealInitialState()) {
    on<TodaydealDataEvent>((event, emit) async {
      emit(TodaydealLoadingState());
      try {
        TodaydealModel model = await fetchDataFromApi();
        if (model.status == 200) {
          emit(TodaydealLoadedState(todayData: model));
        } else {
          emit(TodaydealErrorState(
              error: 'An error occurred while fetching data from api'));
        }
      } catch (error) {
        emit(TodaydealErrorState(error: 'An error occurred'));
      }
    });
  }

  fetchDataFromApi() async {
    Map data = {
      'user_id': '12',
    };
    TodaydealModel model;
    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}todaysDeal";
    final Uri url = Uri.parse(apiUrl);
    final response = await http.post(url, body: data);

    model = TodaydealModel.fromJsonMap(json.decode(response.body));
    return model;
  }
}
