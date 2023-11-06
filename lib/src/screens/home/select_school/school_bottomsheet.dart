import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_1/src/screens/home/bloc/select_school/school/school_bloc.dart';
import 'package:task_1/src/screens/home/bloc/select_school/school/school_event.dart';
import 'package:task_1/src/screens/home/bloc/select_school/school/school_state.dart';
import 'package:task_1/src/screens/home/select_school/board_bottomsheet.dart';

class SchoolBottomSheet extends StatefulWidget {
  const SchoolBottomSheet({super.key});

  @override
  State<SchoolBottomSheet> createState() => _SchoolBottomSheetState();
}

class _SchoolBottomSheetState extends State<SchoolBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SchoolBloc>(
      create: (context) => SchoolBloc(),
      child: const SchoolSheet(),
    );
  }
}

class SchoolSheet extends StatefulWidget {
  const SchoolSheet({super.key});

  @override
  State<SchoolSheet> createState() => _SchoolSheetState();
}

class _SchoolSheetState extends State<SchoolSheet> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SchoolBloc>(context).add(SchoolDataEvent());
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
        return BlocBuilder<SchoolBloc, SchoolState>(builder: (context, state) {
          if (state is SchoolLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SchoolLoadedState) {
            return Column(
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
                        "Select School",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                // const Padding(
                //   padding: EdgeInsets.only(left: 10),
                //   child: Align(
                //     alignment: Alignment.topLeft,
                //     child: Text(
                //       'Select School:',
                //       style: TextStyle(
                //         fontSize: 21,
                //         fontWeight: FontWeight.w500,
                //       ),
                //     ),
                //   ),
                // ),
                Container(
                  padding: const EdgeInsets.all(1),
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: state.schoolData.schoolmodelData.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          //  Navigator.of(context).pop();
                          showModalBottomSheet(
                            context: context,
                            showDragHandle: true,
                            isScrollControlled: true,
                            barrierColor: Colors.transparent,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(15.0)),
                            ),
                            builder: (context) {
                              return BoardBottomSheet(
                                schoolId: state
                                    .schoolData.schoolmodelData[index].id
                                    .toString(),
                              );
                            },
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
                                      Text(state.schoolData
                                          .schoolmodelData[index].name),
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
            );
          } else if (state is SchoolErrorState) {
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
