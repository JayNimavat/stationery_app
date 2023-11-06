import 'package:task_1/src/model/home/second_bannerlist/second_bannerlist.dart';

abstract class SecondBannerListState {}

class SecondBannerListInitialState extends SecondBannerListState {}

class SecondBannerListLoadingState extends SecondBannerListState {}

class SecondBannerListLoadedState extends SecondBannerListState {
  final SecondBannerListModel secondBannerListData;

  SecondBannerListLoadedState({required this.secondBannerListData});
}

class SecondBannerListErrorState extends SecondBannerListState {
  final String error;

  SecondBannerListErrorState({required this.error});
}
