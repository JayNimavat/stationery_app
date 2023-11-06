import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_1/src/model/category/school_category_model.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/category/bloc/school/event_school_category.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/category/bloc/school/state_school_category.dart';
import 'package:task_1/src/server_url/base_app_url.dart';
import 'package:http/http.dart' as http;

class SchoolCategoryBloc
    extends Bloc<SchoolCategoryEvent, SchoolCategoryState> {
  SchoolCategoryBloc() : super(SchoolCategoryInitialState()) {
    on<SchoolCategoryBtnEvent>((event, emit) async {
      emit(SchoolCategoryLoadingState());
      try {
        SchoolCategoryModel model =
            await fetchDataFromApi(selectedSchoolId: event.selectedSchoolId);
        if (model.status == 200) {
          emit(SchoolCategoryLoadedState(schoolCategoryData: model));
        } else {
          emit(SchoolCategoryErrorState(
              error: 'An error occurred while fetching data from API'));
        }
      } catch (error) {
        // print('Error in SCHOOL CATEGORY BLOC:$error');
        emit(SchoolCategoryErrorState(
            error: 'An error cocurred in SCHOOL CATEGORY BLOC'));
      }
    });
  }

  fetchDataFromApi({required String selectedSchoolId}) async {
    SchoolCategoryModel model;
    Map data = {
      'id': selectedSchoolId,
    };

    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}schoolCategory";
    final Uri url = Uri.parse(apiUrl);
    final response = await http.post(url, body: data);

    model = SchoolCategoryModel.fromJsonMap(json.decode(response.body));
    return model;
  }
}
