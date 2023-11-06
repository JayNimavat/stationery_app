import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:task_1/src/model/home/allProducts/allproduct_model.dart';
import 'package:task_1/src/screens/home/bloc/allproduct/allproduct_event.dart';
import 'package:task_1/src/screens/home/bloc/allproduct/allproduct_state.dart';
import 'package:task_1/src/server_url/base_app_url.dart';

class AllproductBloc extends Bloc<AllproductEvent, AllproductState> {
  AllproductBloc() : super(AllproductInitialState()) {
    on<AllproductdataEvent>((event, emit) async {
      emit(AllproductLoadingState());
      try {
        AllproductModel model = await fetchDataFromApi(
            filterPrice: event.filterPrice, filterSortBy: event.filterSortBy);
        if (model.status == 200) {
          emit(AllproductLoadedState(productData: model));
        } else {
          emit(AllproductErrorState(
              error: 'Error occurred while fetch data from API'));
        }
      } catch (error) {
        emit(AllproductErrorState(error: 'An error occurred'));
      }
    });
  }

  fetchDataFromApi(
      {required String filterPrice, required String filterSortBy}) async {
    AllproductModel model;
    Map data = {
      'user_id': '12',
      'filter_price': filterPrice,
      'filter_sort_by': filterSortBy,
    };
    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}allProduct";
    final Uri url = Uri.parse(apiUrl);
    final response = await http.post(url, body: data);

    model = AllproductModel.fromJsonMap(json.decode(response.body));
    return model;
  }
}
