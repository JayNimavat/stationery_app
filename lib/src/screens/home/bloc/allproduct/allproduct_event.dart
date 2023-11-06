abstract class AllproductEvent {}

class AllproductdataEvent extends AllproductEvent {
  final String filterPrice;
  final String filterSortBy;

  AllproductdataEvent({required this.filterPrice, required this.filterSortBy});
}
