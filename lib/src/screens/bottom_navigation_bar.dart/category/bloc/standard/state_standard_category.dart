import 'package:task_1/src/model/category/standard_category_model.dart';

abstract class StandardCategoryState {}

class StandardCategoryInitialState extends StandardCategoryState {}

class StandardCategoryLoadingState extends StandardCategoryState {}

class StandardCategoryLoadedState extends StandardCategoryState {
  final StandardCategoryModel standardCategoryData;

  StandardCategoryLoadedState({required this.standardCategoryData});
}

class StandardCategoryErrorState extends StandardCategoryState {
  final String error;

  StandardCategoryErrorState({required this.error});
}
