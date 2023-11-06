abstract class MediumEvent {}

class MediumDataEvent extends MediumEvent {
  final String boardId;

  MediumDataEvent({required this.boardId});
}
