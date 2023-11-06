import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_1/src/model/category/medium_category_model.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/category/bloc/medium/event_medium_category.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/category/bloc/medium/state_medium_category.dart';
import 'package:task_1/src/server_url/base_app_url.dart';
import 'package:http/http.dart' as http;

class MediumCategoryBloc
    extends Bloc<MediumCategoryEvent, MediumCategoryState> {
  MediumCategoryBloc() : super(MediumCategoryInitialState()) {
    on<MediumCategoryBtnEvent>((event, emit) async {
      emit(MediumCategoryLoadingState());
      try {
        MediumCategoryModel model =
            await fetchDataFromApi(selectedMediumId: event.selectedMediumId);
        if (model.status == 200) {
          emit(MediumCategoryLoadedState(mediumCategoryData: model));
        } else {
          emit(MediumCategoryErrorState(
              error: 'An error occurred while fetching data from API'));
        }
      } catch (error) {
        // print('Error in MEDIUM CATEGORY BLOC:$error');
        emit(MediumCategoryErrorState(
            error: 'An error occurred in MEDIUM CATEGORY BLOC'));
      }
    });
  }

  fetchDataFromApi({required String selectedMediumId}) async {
    MediumCategoryModel model;
    Map data = {
      'id': selectedMediumId,
    };

    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}mediumCategory";
    final Uri url = Uri.parse(apiUrl);
    final response = await http.post(url, body: data);

    model = MediumCategoryModel.fromJsonMap(json.decode(response.body));
    return model;
  }
}
