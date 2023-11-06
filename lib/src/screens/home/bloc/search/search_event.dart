abstract class SearchEvent {}

class SearchBtnEvent extends SearchEvent {
  final String keyword;

  SearchBtnEvent({required this.keyword});
}
