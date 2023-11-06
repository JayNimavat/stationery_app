import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_1/src/model/category/board_category_model.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/category/bloc/board/event_board_category.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/category/bloc/board/state_board_category.dart';
import 'package:task_1/src/server_url/base_app_url.dart';
import 'package:http/http.dart' as http;

class BoardCategoryBloc extends Bloc<BoardCategoryEvent, BoardCategoryState> {
  BoardCategoryBloc() : super(BoardCategoryInitialState()) {
    on<BoardCategoryBtnEvent>((event, emit) async {
      emit(BoardCategoryLoadingState());
      try {
        BoardCategoryModel model =
            await fetchDataFromApi(selectedBoardId: event.selectedBoardId);
        if (model.status == 200) {
          emit(BoardCategoryLoadedState(boardCategoryData: model));
        } else {
          emit(BoardCategoryErrorState(
              error: 'An error occurred while fetching data from API'));
        }
      } catch (error) {
        // print('Error in BOARD CATEGORY BLOC:$error');
        emit(BoardCategoryErrorState(
            error: 'An error ocuurred in BOARD CATEGORY BLOC'));
      }
    });
  }

  fetchDataFromApi({required String selectedBoardId}) async {
    BoardCategoryModel model;
    Map data = {
      'id': selectedBoardId,
    };

    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}boardCategory";
    final Uri url = Uri.parse(apiUrl);
    final response = await http.post(url, body: data);

    model = BoardCategoryModel.fromJsonMap(json.decode(response.body));
    return model;
  }
}
