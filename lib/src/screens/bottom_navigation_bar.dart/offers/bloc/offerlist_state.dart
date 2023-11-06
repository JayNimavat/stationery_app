import 'package:task_1/src/model/offer/offer_list_model.dart';

abstract class OfferListState {}

class OfferListInitialState extends OfferListState {}

class OfferListLoadingState extends OfferListState {}

class OfferListLoadedState extends OfferListState {
  final OfferListModel offerListData;

  OfferListLoadedState({required this.offerListData});
}

class OfferListErrorState extends OfferListState {
  final String error;

  OfferListErrorState({required this.error});
}
