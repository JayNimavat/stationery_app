import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_1/src/model/category/standard_category_model.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/category/bloc/standard/event_standard_category.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/category/bloc/standard/state_standard_category.dart';
import 'package:task_1/src/server_url/base_app_url.dart';
import 'package:http/http.dart' as http;

class StandardCategoryBloc
    extends Bloc<StandardCategoryEvenet, StandardCategoryState> {
  StandardCategoryBloc() : super(StandardCategoryInitialState()) {
    on<StandardCategoryBtnEvent>((event, emit) async {
      emit(StandardCategoryLoadingState());
      try {
        StandardCategoryModel model = await fetchDataFromApi(
            selectedStandardId: event.selectedStandardId);
        if (model.status == 200) {
          emit(StandardCategoryLoadedState(standardCategoryData: model));
        } else {
          emit(StandardCategoryErrorState(
              error: 'An error occurred while fetching data from API'));
        }
      } catch (error) {
        // print('Error in STANDARD CATEGORY BLOC:$error');
        emit(StandardCategoryErrorState(
            error: 'An error occurred in STANDARD CATEGORY BLOC'));
      }
    });
  }

  fetchDataFromApi({required String selectedStandardId}) async {
    StandardCategoryModel model;
    Map data = {
      'id': selectedStandardId,
    };

    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}standarCategory";
    final Uri url = Uri.parse(apiUrl);
    final response = await http.post(url, body: data);

    model = StandardCategoryModel.fromJsonMap(json.decode(response.body));
    return model;
  }
}
