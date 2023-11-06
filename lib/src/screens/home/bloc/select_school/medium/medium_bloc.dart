import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_1/src/model/home/select_school/medium_model.dart';
import 'package:task_1/src/screens/home/bloc/select_school/medium/medium_event.dart';
import 'package:task_1/src/screens/home/bloc/select_school/medium/medium_state.dart';
import 'package:task_1/src/server_url/base_app_url.dart';
import 'package:http/http.dart' as http;

class MediumBloc extends Bloc<MediumEvent, MediumState> {
  MediumBloc() : super(MediumInitialState()) {
    on<MediumDataEvent>((event, emit) async {
      emit(MediumLoadingState());
      try {
        MediumModel model = await fetchDataFromApi(boardId: event.boardId);
        if (model.status == 200) {
          emit(MediumLoadedState(mediumData: model));
        } else {
          emit(MediumErrorState(
              error: 'An error occurred while fetching data from API'));
        }
      } catch (error) {
        emit(MediumErrorState(error: 'An error occurred'));
      }
    });
  }

  fetchDataFromApi({required String boardId}) async {
    MediumModel model;
    Map data = {
      'board_id': boardId,
    };
    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}medium";
    final Uri url = Uri.parse(apiUrl);
    final response = await http.post(url, body: data);

    model = MediumModel.fromJsonMap(json.decode(response.body));
    return model;
  }
}
