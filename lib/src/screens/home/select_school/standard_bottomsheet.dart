import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_1/src/screens/home/bloc/select_school/standard/standard_bloc.dart';
import 'package:task_1/src/screens/home/bloc/select_school/standard/standard_event.dart';
import 'package:task_1/src/screens/home/bloc/select_school/standard/standard_state.dart';
import 'package:task_1/src/screens/home/product_categorywise/categorywise_product.dart';

class StandardBottomSheet extends StatefulWidget {
  final String mediumId;
  const StandardBottomSheet({super.key, required this.mediumId});

  @override
  State<StandardBottomSheet> createState() => _StandardBottomSheetState();
}

class _StandardBottomSheetState extends State<StandardBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<StandardBloc>(
      create: (context) => StandardBloc(),
      child: StandardSheet(mediumId: widget.mediumId),
    );
  }
}

class StandardSheet extends StatefulWidget {
  final String mediumId;
  const StandardSheet({super.key, required this.mediumId});

  @override
  State<StandardSheet> createState() => _StandardSheetState();
}

class _StandardSheetState extends State<StandardSheet> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<StandardBloc>(context)
        .add(StandardDataEvent(mediumId: widget.mediumId));
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.37, // Adjust this value as needed
      minChildSize: 0.27,
      maxChildSize: 0.74,
      snap: true,
      builder: (context, scrollController) {
        return BlocBuilder<StandardBloc, StandardState>(
            builder: (context, state) {
          if (state is StandardLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is StandardLoadedState) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: const Icon(
                              Icons.arrow_back,
                              size: 29,
                            ),
                          ),
                        ],
                      ),
                      const Positioned(
                        top: 0,
                        bottom: 0,
                        left: 125,
                        child: Text(
                          "Select Standard",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 1.5,
                    padding: const EdgeInsets.all(1),
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: state.standardData.standardmodelData.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).popUntil(
                                (Route<dynamic> route) => route.isFirst);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CategorywiseProduct(
                                  standardId: state
                                      .standardData.standardmodelData[index].id
                                      .toString(),
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: Column(
                              children: [
                                Container(
                                  height: 43,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: Colors.amber,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Text(state.standardData
                                            .standardmodelData[index].name),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else if (state is StandardErrorState) {
            return Center(
              child: Text(state.error),
            );
          }
          return Container();
        });
      },
    );
  }
}
