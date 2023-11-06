import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_1/src/screens/home/bloc/brands_bottomsheet/brands_bloc.dart';
import 'package:task_1/src/screens/home/bloc/brands_bottomsheet/brands_event.dart';
import 'package:task_1/src/screens/home/bloc/brands_bottomsheet/brands_state.dart';
import 'package:task_1/src/screens/home/brands/brands.dart';

class BrandsBottomSheet extends StatefulWidget {
  const BrandsBottomSheet({super.key});

  @override
  State<BrandsBottomSheet> createState() => _BrandsBottomSheetState();
}

class _BrandsBottomSheetState extends State<BrandsBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<BrandsBloc>(
      create: (context) => BrandsBloc(),
      child: const BrandsSheet(),
    );
  }
}

class BrandsSheet extends StatefulWidget {
  const BrandsSheet({super.key});

  @override
  State<BrandsSheet> createState() => _BrandsSheetState();
}

class _BrandsSheetState extends State<BrandsSheet> {
  List<String> selectedBrandIds = []; // Store selected brands here

  // Function to handle brand selection
  void handleBrandSelection(String brandId) {
    setState(() {
      if (selectedBrandIds.contains(brandId)) {
        selectedBrandIds.remove(brandId);
      } else {
        selectedBrandIds.add(brandId);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<BrandsBloc>(context).add(BrandsDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BrandsBloc, BrandsState>(
      builder: (context, state) {
        if (state is BrandsLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is BrandsLoadedState) {
          return DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.53, // Adjust this value as needed
            minChildSize: 0.27,
            maxChildSize: 0.68,
            snap: true,
            builder: (context, scrollController) {
              return Container(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: state.brandsdata.brandsmodelData.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                        handleBrandSelection(state
                            .brandsdata.brandsmodelData[index].id
                            .toString());
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BrandswiseProduct(
                              brandId: state
                                  .brandsdata.brandsmodelData[index].id
                                  .toString(),
                              selectedBrandIds: selectedBrandIds,
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(4, 5, 4, 5),
                        child: Container(
                          height: 43,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.amber,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(state
                                    .brandsdata.brandsmodelData[index].name),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        } else if (state is BrandsErrorState) {
          return Center(
            child: Text(state.error),
          );
        }
        return Container();
      },
    );
  }
}
