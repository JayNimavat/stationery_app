import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_1/src/model/orders/cancel_order_model.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/orders/bloc/cancel_order/event_cancel_order.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/orders/bloc/cancel_order/state_cancel_order.dart';
import 'package:task_1/src/server_url/base_app_url.dart';
import 'package:http/http.dart' as http;

class CancelOrderBloc extends Bloc<CancelOrderEvent, CancelOrderState> {
  CancelOrderBloc() : super(CancelOrderInitialState()) {
    on<CancelOrderDataEvent>((event, emit) async {
      emit(CancelOrderLoadingState());
      try {
        CancelOrderModel model = await fetchDataFromApi(
          cancelReason: event.cancelReason,
          orderId: event.orderId,
        );
        if (model.status == 200) {
          emit(CancelOrderLoadedState(cancelOrderData: model));
        } else {
          emit(CancelOrderErrorState(
              error: 'An error occurred while fetching data from API'));
        }
      } catch (error) {
        // print('Error in CANCEL ORDER BLOC:$error');
        emit(CancelOrderErrorState(
            error: 'An error occurred in CANCEL ORDER BLOC'));
      }
    });
  }

  fetchDataFromApi({
    required String cancelReason,
    required String orderId,
  }) async {
    CancelOrderModel model;
    Map data = {
      'user_id': '12',
      'cancel_reason': cancelReason,
      'order_id': orderId,
    };

    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}cancelOrder";
    final Uri url = Uri.parse(apiUrl);
    final response = await http.post(url, body: data);

    model = CancelOrderModel.fromJsonMap(json.decode(response.body));
    return model;
  }
}
