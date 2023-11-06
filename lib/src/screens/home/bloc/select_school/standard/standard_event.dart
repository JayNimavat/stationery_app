abstract class StandardEvent {}

class StandardDataEvent extends StandardEvent {
  final String mediumId;

  StandardDataEvent({required this.mediumId});
}
