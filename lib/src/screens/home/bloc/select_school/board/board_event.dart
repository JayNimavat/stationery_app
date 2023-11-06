abstract class BoardEvent {}

class BoardDataEvent extends BoardEvent {
  final String schoolId;

  BoardDataEvent({required this.schoolId});
}
