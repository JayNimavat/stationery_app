import 'package:task_1/src/model/home/select_school/standard_model.dart';

abstract class StandardState {}

class StandardInitialState extends StandardState {}

class StandardLoadingState extends StandardState {}

class StandardLoadedState extends StandardState {
  final StandardModel standardData;

  StandardLoadedState({required this.standardData});
}

class StandardErrorState extends StandardState {
  final String error;

  StandardErrorState({required this.error});
}
