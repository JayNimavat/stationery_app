import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_1/src/model/home/search/search_model.dart';
import 'package:task_1/src/screens/home/bloc/search/search_event.dart';
import 'package:task_1/src/screens/home/bloc/search/search_state.dart';
import 'package:task_1/src/server_url/base_app_url.dart';
import 'package:http/http.dart' as http;

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitialState()) {
    on<SearchBtnEvent>((event, emit) async {
      emit(SearchLoadingState());
      try {
        SearchModel model = await fetchDataFromApi(keyword: event.keyword);
        if (model.status == 200) {
          emit(SearchLoadedState(search: model));
        } else {
          emit(SearchErrorState(
              error: 'An error occurred while fetching SEARCHING PRODUCT'));
        }
      } catch (error) {
        // print('Error in SEARCH BLOC:$error');
        emit(SearchErrorState(error: 'An error occurred in SEARCH BLOC'));
      }
    });
  }

  fetchDataFromApi({required String keyword}) async {
    SearchModel model;
    Map data = {
      'user_id': '12',
      'keyword': keyword,
    };

    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}search";
    final Uri url = Uri.parse(apiUrl);
    final response = await http.post(url, body: data);

    // print("SEARCH RESPONSE STATUS CODE: ${response.statusCode}");
    // print("SEARCH RESPONSE: ${response.body}");

    model = SearchModel.fromJSonMap(json.decode(response.body));
    return model;
  }
}
