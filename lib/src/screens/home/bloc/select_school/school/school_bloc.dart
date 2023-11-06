import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_1/src/model/home/select_school/school_model.dart';
import 'package:task_1/src/screens/home/bloc/select_school/school/school_event.dart';
import 'package:task_1/src/screens/home/bloc/select_school/school/school_state.dart';
import 'package:task_1/src/server_url/base_app_url.dart';
import 'package:http/http.dart' as http;

class SchoolBloc extends Bloc<SchoolEvent, SchoolState> {
  SchoolBloc() : super(SchoolInitialState()) {
    on<SchoolDataEvent>((event, emit) async {
      emit(SchoolLoadingState());
      try {
        SchoolModel model = await fetchDataFromApi();
        if (model.status == 200) {
          emit(SchoolLoadedState(schoolData: model));
        } else {
          emit(SchoolErrorState(
              error: 'An error occurred while fetching data from API'));
        }
      } catch (error) {
        emit(SchoolErrorState(error: 'An error occurred'));
      }
    });
  }

  fetchDataFromApi() async {
    SchoolModel model;
    const apiUrl = '${SchoolEcommBaseAppUrl.baseAppUrl}school';
    final Uri url = Uri.parse(apiUrl);
    final response = await http.post(url);

    model = SchoolModel.fromJsonMap(json.decode(response.body));
    return model;
  }
}
