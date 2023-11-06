abstract class CatwiseProductEvent {}

class CatwiseProductDataEvent extends CatwiseProductEvent {
  final String standardId;

  CatwiseProductDataEvent({required this.standardId});
}
