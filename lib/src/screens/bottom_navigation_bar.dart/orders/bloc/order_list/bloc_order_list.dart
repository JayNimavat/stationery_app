import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_1/src/model/orders/order_list_model.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/orders/bloc/order_list/event_order_list.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/orders/bloc/order_list/state_order_list.dart';
import 'package:task_1/src/server_url/base_app_url.dart';
import 'package:http/http.dart' as http;

class OrderListBloc extends Bloc<OrderListEvent, OrderListState> {
  OrderListBloc() : super(OrderListInitialState()) {
    on<OrderListDataEvent>((event, emit) async {
      emit(OrderListLoadingState());
      try {
        OrderListModel model = await fetchDataFromApi(
          orderType: event.orderType,
        );
        if (model.status == 200) {
          emit(OrderListLoadedState(orderListData: model));
        } else {
          emit(OrderListErrorState(
              error: 'An error occurred while fetching data from API'));
        }
      } catch (error) {
        // print('Error in ORDER LIST BLOC:$error');
        emit(
            OrderListErrorState(error: 'An error occurred in ORDER LIST BLOC'));
      }
    });
  }

  fetchDataFromApi({required String orderType}) async {
    OrderListModel model;
    Map data = {
      'user_id': '12',
      'order_type': orderType,
    };
    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}orderList";
    final Uri url = Uri.parse(apiUrl);
    final response = await http.post(url, body: data);

    model = OrderListModel.fromJsonMap(json.decode(response.body));
    return model;
  }
}
