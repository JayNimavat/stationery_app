import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_1/src/model/home/product_detail/product_detail_model.dart';
import 'package:task_1/src/screens/home/bloc/product_detail/event_product_detail.dart';
import 'package:task_1/src/screens/home/bloc/product_detail/state_product_detail.dart';
import 'package:task_1/src/server_url/base_app_url.dart';
import 'package:http/http.dart' as http;

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  ProductDetailBloc() : super(ProductDetailInitialState()) {
    on<ProductDetailDataEvent>((event, emit) async {
      emit(ProductDetailLoadingState());
      try {
        ProductDetailModel model =
            await fetchDataFromApi(productId: event.productId);
        if (model.status == 200) {
          emit(ProductDetailLoadedState(productDetailData: model));
        } else {
          emit(ProductDetailErrorState(
              error: 'An error occurred while fetching data fromAPI'));
        }
      } catch (error) {
        //  print('Error during API request: $error');
        emit(ProductDetailErrorState(error: 'An error occurred'));
      }
    });
  }

  fetchDataFromApi({required String productId}) async {
    ProductDetailModel model;
    Map data = {
      'product_id': productId,
      'user_id': '12',
    };

    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}productDetail";
    final Uri url = Uri.parse(apiUrl);
    final response = await http.post(url, body: data);

    model = ProductDetailModel.fromJsonMap(json.decode(response.body));
    return model;
  }
}
