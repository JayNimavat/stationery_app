import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_1/src/model/home/features/features_model.dart';
import 'package:task_1/src/screens/home/bloc/features/features_event.dart';
import 'package:task_1/src/screens/home/bloc/features/features_state.dart';
import 'package:task_1/src/server_url/base_app_url.dart';
import 'package:http/http.dart' as http;

class FeaturesBloc extends Bloc<FeaturesEvent, FeaturesState> {
  FeaturesBloc() : super(FeaturesInitialState()) {
    on<FeaturesDataEvent>((event, emit) async {
      emit(FeaturesLoadingState());
      try {
        FeaturesModel model = await fetchDataFromApi();
        if (model.status == 200) {
          emit(FeaturesLoadedState(featuresData: model));
        } else {
          emit(FeaturesErrorState(
              error: 'An error occurred while fetching data from API'));
        }
      } catch (error) {
        emit(FeaturesErrorState(error: 'An error occurred'));
      }
    });
  }

  fetchDataFromApi() async {
    Map data = {
      'user_id': '12',
    };
    FeaturesModel model;
    const apiUrl = '${SchoolEcommBaseAppUrl.baseAppUrl}features';
    final Uri url = Uri.parse(apiUrl);
    final response = await http.post(url, body: data);

    model = FeaturesModel.fromJsonMap(json.decode(response.body));
    return model;
  }
}
