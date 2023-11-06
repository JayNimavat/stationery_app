import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_1/src/model/cart/add_to_cart_model.dart';
import 'package:task_1/src/model/cart/remove_cart_model.dart';
import 'package:task_1/src/screens/cart/bloc/cart/cart_event.dart';
import 'package:task_1/src/screens/cart/bloc/cart/cart_state.dart';
import 'package:http/http.dart' as http;
import 'package:task_1/src/server_url/base_app_url.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitialState()) {
    on<AddToCartEvent>((event, emit) async {
      emit(CartLoadingState());
      try {
        AddToCartModel addToCartModel =
            await fetchDataFromApi(productId: event.productId, qty: event.qty);
        if (addToCartModel.status == 200) {
          emit(AddToCartLoadedState(cartData: addToCartModel));
        } else {
          emit(CartErrorState(
              error: 'An error occurred while adding item to cart'));
        }
      } catch (error) {
        //  print("ADD CART ERROR: $error");
        emit(CartErrorState(error: 'An error occurred in ADD TO CART EVENT'));
      }
    });

    on<RemoveCartEvent>((event, emit) async {
      emit(CartLoadingState());
      try {
        RemoveCartModel removeCartModel =
            await fetchDataFromRemoveCartApi(productId: event.productId);
        if (removeCartModel.status == 200) {
          emit(RemoveCartLoadedState(cartData: removeCartModel));
        } else {
          emit(CartErrorState(
              error: 'An error occurred while remove item from cart'));
        }
      } catch (error) {
        //  print("REMOVE CART ERROR: $error");
        emit(CartErrorState(error: 'An error occurred in REMOVE CART EVENT'));
      }
    });
  }

  fetchDataFromApi({required String productId, required String qty}) async {
    AddToCartModel addToCartModel;
    Map data = {
      'user_id': '12',
      'product_id': productId,
      'qty': qty,
    };

    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}addToCart";
    final Uri url = Uri.parse(apiUrl);
    final response = await http.post(url, body: data);
    // print("ADD TO CART STATUS CODE : ${response.statusCode}");
    // print("ADD CART BODY: ${response.body}");
    addToCartModel = AddToCartModel.fromJsonMap(json.decode(response.body));
    return addToCartModel;
  }

  fetchDataFromRemoveCartApi({required String productId}) async {
    RemoveCartModel removeCartModel;
    Map data = {
      'product_id': productId,
      'user_id': '12',
    };

    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}removeCart";
    final Uri url = Uri.parse(apiUrl);
    final response = await http.post(url, body: data);
    // print("REMOVE CART STATUS CODE : ${response.statusCode}");
    // print("REMOVE CART BODY: ${response.body}");
    removeCartModel = RemoveCartModel.fromJsonMap(json.decode(response.body));
    return removeCartModel;
  }
}
