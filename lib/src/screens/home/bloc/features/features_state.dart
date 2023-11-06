import 'package:task_1/src/model/home/features/features_model.dart';

abstract class FeaturesState {}

class FeaturesInitialState extends FeaturesState {}

class FeaturesLoadingState extends FeaturesState {}

class FeaturesLoadedState extends FeaturesState {
  final FeaturesModel featuresData;

  FeaturesLoadedState({required this.featuresData});
}

class FeaturesErrorState extends FeaturesState {
  final String error;

  FeaturesErrorState({required this.error});
}
