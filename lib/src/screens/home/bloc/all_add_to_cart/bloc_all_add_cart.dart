import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_1/src/model/home/all_add_to_cart/all_add_to_cart_model.dart';
import 'package:task_1/src/screens/home/bloc/all_add_to_cart/event_all_add_to_cart.dart';
import 'package:task_1/src/screens/home/bloc/all_add_to_cart/state_all_add_to_cart.dart';
import 'package:task_1/src/server_url/base_app_url.dart';
import 'package:http/http.dart' as http;

class AllAddToCartBloc extends Bloc<AllAddToCartEvent, AllAddToCartState> {
  AllAddToCartBloc() : super(AllAddToCartInitialState()) {
    on<AllAddToCartDataEvent>((event, emit) async {
      emit(AllAddToCartLoadingState());
      try {
        AllAddToCartModel model =
            await fetchDataFromApi(standardId: event.standardId);
        if (model.status == 200) {
          emit(AllAddToCartLoadedState(allAddToCartData: model));
        } else {
          emit(AllAddToCartErrorState(
              error: 'An error occurred while AllAddToCart'));
        }
      } catch (error) {
        emit(AllAddToCartErrorState(
            error: 'An error occurred in AllAddToCartBloc'));
      }
    });
  }

  fetchDataFromApi({required String standardId}) async {
    AllAddToCartModel model;
    Map data = {
      'user_id': '12',
      'standard_id': standardId,
    };

    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}allAddToCart";
    final Uri url = Uri.parse(apiUrl);
    final response = await http.post(url, body: data);

    model = AllAddToCartModel.fromJsonMap(json.decode(response.body));
    return model;
  }
}
