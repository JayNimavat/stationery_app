import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_1/src/model/home/product_categorywise/categorywise_product_model.dart';
import 'package:task_1/src/screens/home/bloc/product_categorywise/event_catwise_product.dart';
import 'package:task_1/src/screens/home/bloc/product_categorywise/state_catwise_product.dart';
import 'package:task_1/src/server_url/base_app_url.dart';
import 'package:http/http.dart' as http;

class CatwiseProductBloc
    extends Bloc<CatwiseProductEvent, CatwiseProductState> {
  CatwiseProductBloc() : super(CatwiseProductInitialState()) {
    on<CatwiseProductDataEvent>((event, emit) async {
      emit(CatwiseProductLoadingState());
      try {
        CatwiseProductModel model =
            await fetchDataFromApi(standardId: event.standardId);
        if (model.status == 200) {
          emit(CatwiseProductLoadedState(catwiseProductData: model));
        } else {
          emit(CatwiseProductErrorState(
              error: 'An error occurred while fetching data from API'));
        }
      } catch (error) {
        emit(CatwiseProductErrorState(error: 'An error occurred'));
      }
    });
  }
  fetchDataFromApi({required String standardId}) async {
    CatwiseProductModel model;
    Map data = {
      'user_id': '12',
      'standard_id': standardId,
    };
    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}categoryWiseProduct";
    final Uri url = Uri.parse(apiUrl);
    final response = await http.post(url, body: data);

    model = CatwiseProductModel.fromJsonMap(json.decode(response.body));
    return model;
  }
}
