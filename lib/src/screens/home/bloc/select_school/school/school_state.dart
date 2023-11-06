import 'package:task_1/src/model/home/select_school/school_model.dart';

abstract class SchoolState {}

class SchoolInitialState extends SchoolState {}

class SchoolLoadingState extends SchoolState {}

class SchoolLoadedState extends SchoolState {
  final SchoolModel schoolData;

  SchoolLoadedState({required this.schoolData});
}

class SchoolErrorState extends SchoolState {
  final String error;

  SchoolErrorState({required this.error});
}
