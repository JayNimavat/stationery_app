import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_1/src/model/favorites/save_wish_model.dart';
import 'package:task_1/src/model/favorites/remove_wish_model.dart';
import 'package:task_1/src/model/favorites/wish_list_model.dart';
import 'package:task_1/src/screens/favorites/bloc/save_wish/event_save_wish.dart';
import 'package:task_1/src/screens/favorites/bloc/save_wish/state_save_wish.dart';
import 'package:http/http.dart' as http;
import 'package:task_1/src/server_url/base_app_url.dart';

class WishBloc extends Bloc<WishEvent, WishState> {
  WishBloc() : super(WishInitialState()) {
    on<SaveWishDataEvent>((event, emit) async {
      emit(WishLoadingState());

      try {
        SaveWishModel saveWishModel =
            await fetchDataFromApi(productId: event.productId);
        if (saveWishModel.status == 200) {
          emit(WishLoadedState(wishData: saveWishModel));
        } else {
          emit(
              WishErrorState(error: 'An error occurred while saving the wish'));
        }
      } catch (error) {
        emit(WishErrorState(error: 'An error occurred'));
      }
    });

    on<RemoveWishEvent>((event, emit) async {
      emit(WishLoadingState());
      try {
        RemoveWishModel removeWishModel =
            await fetchDataFromRemoveWishApi(wishlistId: event.wishlistId);
        if (removeWishModel.status == 200) {
          emit(RemoveWishLoadedState(wishData: removeWishModel));
        } else {
          emit(WishErrorState(
              error: 'An error occurred while removing the wish'));
        }
      } catch (error) {
        emit(WishErrorState(error: 'An error occurred'));
      }
    });
  }

  fetchDataFromApi({required String productId}) async {
    SaveWishModel model;
    Map data = {
      'user_id': '12',
      'product_id': productId,
    };

    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}saveWish";
    final Uri url = Uri.parse(apiUrl);
    final response = await http.post(url, body: data);
    // print("SAVE WISH status code: ${response.statusCode}");
    // print("SAVE WISH BODY: ${response.body}");
    model = SaveWishModel.fromJsonMap(json.decode(response.body));
    return model;
  }

  fetchDataFromRemoveWishApi({required String wishlistId}) async {
    RemoveWishModel model;
    Map data = {
      'wishlist_id': wishlistId,
    };

    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}removeWish";
    final Uri url = Uri.parse(apiUrl);
    final response = await http.post(url, body: data);
    // print("REMOVE WISH status code: ${response.statusCode}");
    // print("REMOVE WISH BODY: ${response.body}");
    model = RemoveWishModel.fromJsonMap(json.decode(response.body));
    return model;
  }

  isProductInWishlist(String productId) async {
    WishListModel model;
    Map data = {
      'user_id': '12',
      'product_id': productId,
    };

    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}wishList";
    final Uri url = Uri.parse(apiUrl);
    final response = await http.post(url, body: data);

    model = WishListModel.fromJsonMap(json.decode(response.body));
    return model;
  }
}
