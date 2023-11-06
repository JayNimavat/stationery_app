import 'package:task_1/src/model/home/select_school/medium_model.dart';

abstract class MediumState {}

class MediumInitialState extends MediumState {}

class MediumLoadingState extends MediumState {}

class MediumLoadedState extends MediumState {
  MediumModel mediumData;

  MediumLoadedState({required this.mediumData});
}

class MediumErrorState extends MediumState {
  final String error;

  MediumErrorState({required this.error});
}
