abstract class StandardCategoryEvenet {}

class StandardCategoryBtnEvent extends StandardCategoryEvenet {
  final String selectedStandardId;

  StandardCategoryBtnEvent({required this.selectedStandardId});
}
