import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:task_1/src/model/home/bannerlist/bannerlist_model.dart';
import 'package:task_1/src/screens/home/bloc/bannerlist/banner_event.dart';
import 'package:task_1/src/screens/home/bloc/bannerlist/banner_state.dart';
import 'package:task_1/src/server_url/base_app_url.dart';
import 'dart:convert';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  BannerBloc() : super(BannerInitialState()) {
    on<FetchBannerEvent>((event, emit) async {
      emit(BannerLoadingState());
      try {
        BannerlistModel model = await fetchDataFromApi();
        if (model.status == 200) {
          emit(BannerLoadedState(bannerData: model, currentPage: 0));
        } else {
          emit(
              BannerErrorState(error: "An error occurred while fetching data"));
        }
      } catch (error) {
        emit(BannerErrorState(error: "An error occurred"));
      }
    });
  }

  fetchDataFromApi() async {
    BannerlistModel model;
    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}bannerList";
    final Uri url = Uri.parse(apiUrl);
    final response = await http.post(url);
    model = BannerlistModel.fromJsonMap(json.decode(response.body));
    return model;
  }
}
