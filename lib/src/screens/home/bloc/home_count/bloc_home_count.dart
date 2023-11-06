import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_1/src/model/home_count/home_count_model.dart';
import 'package:task_1/src/screens/home/bloc/home_count/event_home_count.dart';
import 'package:task_1/src/screens/home/bloc/home_count/state_home_count.dart';
import 'package:task_1/src/server_url/base_app_url.dart';
import 'package:http/http.dart' as http;

class HomeCountBloc extends Bloc<HomeCountEvent, HomeCountState> {
  HomeCountBloc() : super(HomeCountInitialState()) {
    on<HomeCountBtnEvent>((event, emit) async {
      emit(HomeCountLoadingState());
      try {
        HomeCountModel model = await fetchDataFromApi();

        if (model.status == 200) {
          emit(HomeCountLoadedState(homeCountData: model));
        } else {
          emit(HomeCountErrorState(
              error: 'An error occurred while fetching data from API'));
        }
      } catch (error) {
        // print('Error in HOMECOUNT BLOC:$error');
        emit(HomeCountErrorState(error: 'An error occurred in HOMECOUNT BLOC'));
      }
    });
  }

  fetchDataFromApi() async {
    HomeCountModel model;
    Map data = {
      'user_id': '12',
    };

    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}homeCount";
    final Uri url = Uri.parse(apiUrl);
    final response = await http.post(url, body: data);

    model = HomeCountModel.fromJsonMap(json.decode(response.body));
    return model;
  }
}
