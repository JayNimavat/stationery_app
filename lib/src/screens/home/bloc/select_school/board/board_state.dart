import 'package:task_1/src/model/home/select_school/board_model.dart';

abstract class BoardState {}

class BoardInitialState extends BoardState {}

class BoardLoadingState extends BoardState {}

class BoardLoadedState extends BoardState {
  final BoardModel boardData;

  BoardLoadedState({required this.boardData});
}

class BoardErrorState extends BoardState {
  final String error;

  BoardErrorState({required this.error});
}
