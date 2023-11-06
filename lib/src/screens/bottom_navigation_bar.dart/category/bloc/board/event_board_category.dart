abstract class BoardCategoryEvent {}

class BoardCategoryBtnEvent extends BoardCategoryEvent {
  final String selectedBoardId;

  BoardCategoryBtnEvent({required this.selectedBoardId});
}
