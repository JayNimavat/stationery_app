import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_1/src/model/cart/cart_list_model.dart';
import 'package:task_1/src/screens/cart/bloc/cart_list/event_cart_list.dart';
import 'package:task_1/src/screens/cart/bloc/cart_list/state_cart_list.dart';
import 'package:task_1/src/server_url/base_app_url.dart';
import 'package:http/http.dart' as http;

class CartListBloc extends Bloc<CartListEvent, CartListState> {
  CartListBloc() : super(CartListInitialState()) {
    on<CartListDataEvent>((event, emit) async {
      emit(CartListLoadingState());
      try {
        CartListModel cartListModel = await fetchDataFromApi();
        if (cartListModel.status == 200) {
          emit(CartListLoadedState(cartListData: cartListModel));
        } else {
          emit(CartListErrorState(
              error: 'An error occurred while fetching CART LIST'));
        }
      } catch (error) {
        // print('ERROR OF CARTLIST EVENT:$error');
        CartListErrorState(error: 'Data Not Found');
      }
    });

    // on<UpdateQtyEvent>((event, emit) async {
    //   emit(CartListLoadingState());
    //   try {
    //     CartListModel cartListModel = await fetchDataFromQtyApi(
    //         productId: event.productId, qty: event.qty);
    //     if (cartListModel.status == 200) {
    //       emit(UpdateQtyState(cartListData: cartListModel));
    //     } else {
    //       emit(CartListErrorState(
    //           error: 'An error occurred while fetching UPDATE CART QTY'));
    //     }
    //   } catch (error) {
    //     print('ERROR OF UPDATE CART QTY:$error');
    //     CartListErrorState(error: 'Data Not Found');
    //   }
    // });
  }

  fetchDataFromApi() async {
    CartListModel cartListModel;
    Map data = {
      'user_id': '12',
    };

    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}cartList";
    final Uri url = Uri.parse(apiUrl);
    final response = await http.post(url, body: data);

    cartListModel = CartListModel.fromJsonMap(json.decode(response.body));
    return cartListModel;
  }

  // fetchDataFromQtyApi({required String productId, required String qty}) async {
  //   CartListModel cartListModel;
  //   Map data = {
  //     'user_id': '12',
  //     'product_id': productId,
  //     'qty': qty,
  //   };

  //   const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}cartList";
  //   final Uri url = Uri.parse(apiUrl);
  //   final response = await http.post(url, body: data);
  //   print("UPDATE QTY STATUS CODE : ${response.statusCode}");
  //   print("UPDATE QTY BODY: ${response.body}");
  //   cartListModel = CartListModel.fromJsonMap(json.decode(response.body));
  //   return cartListModel;
  // }
}
