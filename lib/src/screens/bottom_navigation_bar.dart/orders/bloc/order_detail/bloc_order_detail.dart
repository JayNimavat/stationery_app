import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_1/src/model/orders/order_detail_model.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/orders/bloc/order_detail/event_order_detail.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/orders/bloc/order_detail/state_order_detail.dart';
import 'package:task_1/src/server_url/base_app_url.dart';
import 'package:http/http.dart' as http;

class OrderDetailBloc extends Bloc<OrderDetailEvent, OrderDetailState> {
  OrderDetailBloc() : super(OrderDetailInitialState()) {
    on<OrderDetailBtnEvent>((event, emit) async {
      emit(OrderDetailLoadingState());
      try {
        OrderDetailModel model = await fetchDataFromApi(
          orderId: event.orderId,
          orderIDEncrypt: event.orderIDEncrypt,
        );
        if (model.status == 200) {
          emit(OrderDetailLoadedState(orderDetailData: model));
        } else {
          emit(OrderDetailErrorState(
              error: 'An error occurred while fetching data from API'));
        }
      } catch (error) {
        // print('Error in ORDER DETAIL BLOC:$error');
        emit(OrderDetailErrorState(
            error: 'An error occurred in ORDER DETAIL BLOC'));
      }
    });
  }

  fetchDataFromApi(
      {required String orderId, required String orderIDEncrypt}) async {
    OrderDetailModel model;
    Map data = {
      'user_id': '12',
      'order_id': orderId,
      'orderIDEncrypt': orderIDEncrypt,
    };

    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}orderDetail";
    final Uri url = Uri.parse(apiUrl);
    final response = await http.post(url, body: data);

    model = OrderDetailModel.fromJsonMap(json.decode(response.body));
    return model;
  }
}
