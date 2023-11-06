import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_1/src/model/home/flash_deal/flashdeal_model.dart';
import 'package:task_1/src/screens/home/bloc/flash_deal/flashdeal_event.dart';
import 'package:task_1/src/screens/home/bloc/flash_deal/flashdeal_state.dart';
import 'package:http/http.dart' as http;
import 'package:task_1/src/server_url/base_app_url.dart';

class FlashdealBloc extends Bloc<FlashdealEvent, FlashdealState> {
  FlashdealBloc() : super(FlashdealInitialState()) {
    on<FlashdealDataEvent>((event, emit) async {
      emit(FlashdealLoadingState());
      try {
        FlashdealModel model = await fetchDataFromApi();
        if (model.status == 200) {
          emit(FlashdealLoadedState(flashData: model));
        } else {
          emit(FlashdealErrorState(
              error: 'An error occurred while fetching data from API'));
        }
      } catch (error) {
        emit(FlashdealErrorState(error: 'An error occurred'));
      }
    });
  }

  fetchDataFromApi() async {
    Map data = {
      'user_id': '12',
    };
    FlashdealModel model;
    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}flashDeal";
    final Uri url = Uri.parse(apiUrl);
    final response = await http.post(url, body: data);

    model = FlashdealModel.fromJsonMap(json.decode(response.body));
    return model;
  }
}
