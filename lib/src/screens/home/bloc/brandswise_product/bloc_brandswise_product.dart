import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_1/src/model/home/brandswise_product/brandswise_product_model.dart';
import 'package:task_1/src/screens/home/bloc/brandswise_product/event_brandswise_product.dart';
import 'package:task_1/src/screens/home/bloc/brandswise_product/state_brandswise_product.dart';
import 'package:http/http.dart' as http;
import 'package:task_1/src/server_url/base_app_url.dart';

class BrandswiseProductBloc
    extends Bloc<BrandswiseProductEvent, BrandswiseProductState> {
  BrandswiseProductBloc() : super(BrandswiseProductInitialState()) {
    on<BrandswiseProductDataEvent>((event, emit) async {
      emit(BrandswiseProductLoadingState());
      try {
        BrandswiseProductModel model =
            await fetchDataFromApi(brandId: event.brandId);
        if (model.status == 200) {
          emit(BrandswiseProductLoadedState(brandswiseProductData: model));
        } else {
          emit(BrandswiseProductErrorState(
              error: 'An error occurred while fetching data from API'));
        }
      } catch (error) {
        emit(BrandswiseProductErrorState(error: 'An error occurred'));
      }
    });
  }

  fetchDataFromApi({required String brandId}) async {
    BrandswiseProductModel model;
    Map data = {
      'user_id': '12',
      'brand_id': brandId,
    };
    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}brandWiseProduct";
    final Uri url = Uri.parse(apiUrl);
    final response = await http.post(url, body: data);

    model = BrandswiseProductModel.fromJsonMap(json.decode(response.body));
    return model;
  }
}
