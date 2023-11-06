abstract class MediumCategoryEvent {}

class MediumCategoryBtnEvent extends MediumCategoryEvent {
  final String selectedMediumId;

  MediumCategoryBtnEvent({required this.selectedMediumId});
}
