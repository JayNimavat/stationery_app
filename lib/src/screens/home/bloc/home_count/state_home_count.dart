import 'package:task_1/src/model/home_count/home_count_model.dart';

abstract class HomeCountState {}

class HomeCountInitialState extends HomeCountState {}

class HomeCountLoadingState extends HomeCountState {}

class HomeCountLoadedState extends HomeCountState {
  HomeCountModel homeCountData;

  HomeCountLoadedState({required this.homeCountData});
}

class HomeCountErrorState extends HomeCountState {
  final String error;

  HomeCountErrorState({required this.error});
}
