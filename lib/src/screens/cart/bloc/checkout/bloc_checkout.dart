import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_1/src/model/cart/checkout_model.dart';
import 'package:task_1/src/screens/cart/bloc/checkout/event_checkout.dart';
import 'package:task_1/src/screens/cart/bloc/checkout/state_checkout.dart';
import 'package:task_1/src/server_url/base_app_url.dart';
import 'package:http/http.dart' as http;

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc() : super(CheckoutInitialState()) {
    on<CheckoutBtnEvent>((event, emit) async {
      emit(CheckoutLoadingState());
      try {
        CheckoutModel model = await fetchDataFromApi(
          userAddressId: event.userAddressId,
          couponId: event.couponId,
          paymentType: event.paymentType,
          totalDiscount: event.totalDiscount,
          totalAmount: event.totalAmount,
          offerDiscount: event.offerDiscount,
          transactionId: event.transactionId,
        );
        if (model.status == 200) {
          emit(CheckoutLoadedState(checkoutData: model));
        } else {
          emit(CheckoutErrorState(
              error: 'An error occurred while fetching data from CHECKOUT'));
        }
      } catch (error) {
        // print('Error in CHECKOUT BTN:$error');
        emit(CheckoutErrorState(error: 'An error occurred in CHECKOUT BTN'));
      }
    });
  }

  fetchDataFromApi({
    required String userAddressId,
    required String couponId,
    required String paymentType,
    required String totalDiscount,
    required String totalAmount,
    required String offerDiscount,
    required String transactionId,
  }) async {
    CheckoutModel model;
    Map data = {
      'user_id': '12',
      'user_address_id': userAddressId,
      'coupon_id': couponId,
      'payment_type': paymentType,
      'total_discount': totalDiscount,
      'total_amount': totalAmount,
      'offer_discount': offerDiscount,
      'transaction_id': transactionId,
    };

    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}checkOut";
    final Uri url = Uri.parse(apiUrl);
    final response = await http.post(url, body: data);

    model = CheckoutModel.fromJsonMap(json.decode(response.body));
    return model;
  }
}
