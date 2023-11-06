import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_1/src/model/home/select_school/board_model.dart';
import 'package:task_1/src/screens/home/bloc/select_school/board/board_event.dart';
import 'package:task_1/src/screens/home/bloc/select_school/board/board_state.dart';
import 'package:task_1/src/server_url/base_app_url.dart';
import 'package:http/http.dart' as http;

class BoardBloc extends Bloc<BoardEvent, BoardState> {
  BoardBloc() : super(BoardInitialState()) {
    on<BoardDataEvent>((event, emit) async {
      emit(BoardLoadingState());
      try {
        BoardModel model = await fetchDataFromApi(
          schoolId: event.schoolId,
        );
        if (model.status == 200) {
          emit(BoardLoadedState(boardData: model));
        } else {
          emit(BoardErrorState(
              error: 'An error occurred while fetching data from API'));
        }
      } catch (error) {
        emit(BoardErrorState(error: 'An error occurred'));
      }
    });
  }

  fetchDataFromApi({
    required String schoolId,
  }) async {
    BoardModel model;
    Map data = {
      'school_id': schoolId,
    };
    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}board";
    final Uri url = Uri.parse(apiUrl);
    final response = await http.post(url, body: data);

    model = BoardModel.fromJsonMap(json.decode(response.body));
    return model;
  }
}
