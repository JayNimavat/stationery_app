import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_1/src/model/cart/apply_coupon_model.dart';
import 'package:task_1/src/screens/cart/bloc/apply_coupon/event_applycoupon.dart';
import 'package:task_1/src/screens/cart/bloc/apply_coupon/state_applycoupon.dart';
import 'package:task_1/src/server_url/base_app_url.dart';
import 'package:http/http.dart' as http;

class ApplyCouponBloc extends Bloc<ApplyCouponEvent, ApplyCouponState> {
  bool isCouponApplied = false;

  ApplyCouponBloc() : super(ApplyCouponInitialState()) {
    on<ApplyCouponBtnEvent>((event, emit) async {
      emit(ApplyCouponLoadingState());
      try {
        ApplyCouponModel model =
            await fetchDataFromApi(couponCode: event.couponCode);
        if (model.status == 200) {
          emit(ApplyCouponLoadedState(applyCouponData: model));
        } else {
          emit(ApplyCouponErrorState(
              error: 'An error occurred while fetching data from API'));
        }
      } catch (error) {
        emit(ApplyCouponErrorState(
            error: 'An error occurred while apply coupon'));
      }
    });
  }

  fetchDataFromApi({required String couponCode}) async {
    ApplyCouponModel model;
    Map data = {
      'user_id': '12',
      'coupon_code': couponCode,
    };

    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}applyCoupon";
    final Uri url = Uri.parse(apiUrl);
    final response = await http.post(url, body: data);

    model = ApplyCouponModel.fromJsonMap(json.decode(response.body));
    return model;
  }
}
