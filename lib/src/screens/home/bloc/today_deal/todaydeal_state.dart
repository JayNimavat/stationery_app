import 'package:task_1/src/model/home/today_deal/todaydeal_model.dart';

abstract class TodaydealState {}

class TodaydealInitialState extends TodaydealState {}

class TodaydealLoadingState extends TodaydealState {}

class TodaydealLoadedState extends TodaydealState {
  final TodaydealModel todayData;

  TodaydealLoadedState({required this.todayData});
}

class TodaydealErrorState extends TodaydealState {
  final String error;

  TodaydealErrorState({required this.error});
}
