import 'package:task_1/src/model/category/board_category_model.dart';

abstract class BoardCategoryState {}

class BoardCategoryInitialState extends BoardCategoryState {}

class BoardCategoryLoadingState extends BoardCategoryState {}

class BoardCategoryLoadedState extends BoardCategoryState {
  final BoardCategoryModel boardCategoryData;

  BoardCategoryLoadedState({required this.boardCategoryData});
}

class BoardCategoryErrorState extends BoardCategoryState {
  final String error;

  BoardCategoryErrorState({required this.error});
}
