import 'package:task_1/src/model/home/flash_deal/flashdeal_model.dart';

abstract class FlashdealState {}

class FlashdealInitialState extends FlashdealState {}

class FlashdealLoadingState extends FlashdealState {}

class FlashdealLoadedState extends FlashdealState {
  final FlashdealModel flashData;

  FlashdealLoadedState({required this.flashData});
}

class FlashdealErrorState extends FlashdealState {
  final String error;

  FlashdealErrorState({required this.error});
}
