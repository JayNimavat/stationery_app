import 'package:task_1/src/model/home/bannerlist/bannerlist_model.dart';

abstract class BannerState {}

class BannerInitialState extends BannerState {}

class BannerLoadingState extends BannerState {}

class BannerLoadedState extends BannerState {
  final BannerlistModel bannerData;
  final int currentPage;

  BannerLoadedState({required this.bannerData, required this.currentPage});
}

class BannerErrorState extends BannerState {
  final String error;

  BannerErrorState({required this.error});
}
