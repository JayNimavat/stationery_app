abstract class SchoolCategoryEvent {}

class SchoolCategoryBtnEvent extends SchoolCategoryEvent {
  final String selectedSchoolId;

  SchoolCategoryBtnEvent({required this.selectedSchoolId});
}
