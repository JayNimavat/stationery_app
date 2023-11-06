import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_1/src/model/home/select_school/standard_model.dart';
import 'package:task_1/src/screens/home/bloc/select_school/standard/standard_event.dart';
import 'package:task_1/src/screens/home/bloc/select_school/standard/standard_state.dart';
import 'package:task_1/src/server_url/base_app_url.dart';
import 'package:http/http.dart' as http;

class StandardBloc extends Bloc<StandardEvent, StandardState> {
  StandardBloc() : super(StandardInitialState()) {
    on<StandardDataEvent>((event, emit) async {
      emit(StandardLoadingState());
      try {
        StandardModel model = await fetchDataFromApi(mediumId: event.mediumId);
        if (model.status == 200) {
          emit(StandardLoadedState(standardData: model));
        } else {
          emit(StandardErrorState(
              error: "An error occurred while fetching data from API"));
        }
      } catch (error) {
        emit(StandardErrorState(error: 'An error occurred'));
      }
    });
  }

  fetchDataFromApi({required String mediumId}) async {
    StandardModel model;
    Map data = {
      'medium_id': mediumId,
    };
    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}standerd";
    final Uri url = Uri.parse(apiUrl);
    final response = await http.post(url, body: data);

    model = StandardModel.fromJsonMap(json.decode(response.body));
    return model;
  }
}
