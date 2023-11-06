import 'package:task_1/src/model/category/school_category_model.dart';

abstract class SchoolCategoryState {}

class SchoolCategoryInitialState extends SchoolCategoryState {}

class SchoolCategoryLoadingState extends SchoolCategoryState {}

class SchoolCategoryLoadedState extends SchoolCategoryState {
  SchoolCategoryModel schoolCategoryData;

  SchoolCategoryLoadedState({required this.schoolCategoryData});
}

class SchoolCategoryErrorState extends SchoolCategoryState {
  final String error;

  SchoolCategoryErrorState({required this.error});
}
