import 'package:task_1/src/model/category/medium_category_model.dart';

abstract class MediumCategoryState {}

class MediumCategoryInitialState extends MediumCategoryState {}

class MediumCategoryLoadingState extends MediumCategoryState {}

class MediumCategoryLoadedState extends MediumCategoryState {
  final MediumCategoryModel mediumCategoryData;

  MediumCategoryLoadedState({required this.mediumCategoryData});
}

class MediumCategoryErrorState extends MediumCategoryState {
  final String error;

  MediumCategoryErrorState({required this.error});
}
