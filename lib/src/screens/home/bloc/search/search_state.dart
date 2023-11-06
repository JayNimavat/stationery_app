import 'package:task_1/src/model/home/search/search_model.dart';

abstract class SearchState {}

class SearchInitialState extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchLoadedState extends SearchState {
  final SearchModel search;

  SearchLoadedState({required this.search});
}

class SearchErrorState extends SearchState {
  final String error;

  SearchErrorState({required this.error});
}
