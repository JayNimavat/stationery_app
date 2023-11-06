import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_1/src/model/home/brands/brands_model.dart';
import 'package:task_1/src/screens/home/bloc/brands_bottomsheet/brands_event.dart';
import 'package:task_1/src/screens/home/bloc/brands_bottomsheet/brands_state.dart';
import 'package:task_1/src/server_url/base_app_url.dart';
import 'package:http/http.dart' as http;

class BrandsBloc extends Bloc<BrandsEvent, BrandsState> {
  BrandsBloc() : super(BrandsInitialState()) {
    on<BrandsDataEvent>((event, emit) async {
      emit(BrandsLoadingState());
      try {
        BrandsModel model = await fetchDataFromApi();
        if (model.status == 200) {
          emit(BrandsLoadedState(brandsdata: model));
        } else {
          emit(BrandsErrorState(
              error: 'An error occurred while fetching data from API'));
        }
      } catch (error) {
        emit(BrandsErrorState(error: 'An error occurred'));
      }
    });
  }

  fetchDataFromApi() async {
    BrandsModel model;
    const apiUrl = '${SchoolEcommBaseAppUrl.baseAppUrl}brands';
    final Uri url = Uri.parse(apiUrl);
    final response = await http.post(url);

    model = BrandsModel.fromJsonMap(json.decode(response.body));
    return model;
  }
}
