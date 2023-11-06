import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_1/src/screens/home/bloc/select_school/medium/medium_bloc.dart';
import 'package:task_1/src/screens/home/bloc/select_school/medium/medium_event.dart';
import 'package:task_1/src/screens/home/bloc/select_school/medium/medium_state.dart';
import 'package:task_1/src/screens/home/select_school/standard_bottomsheet.dart';

class MediumBottomSheet extends StatefulWidget {
  final String boardId;
  const MediumBottomSheet({
    super.key,
    required this.boardId,
  });

  @override
  State<MediumBottomSheet> createState() => _MediumBottomSheetState();
}

class _MediumBottomSheetState extends State<MediumBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<MediumBloc>(
      create: (context) => MediumBloc(),
      child: MediumSheet(boardId: widget.boardId),
    );
  }
}

class MediumSheet extends StatefulWidget {
  final String boardId;
  const MediumSheet({
    super.key,
    required this.boardId,
  });

  @override
  State<MediumSheet> createState() => _MediumSheetState();
}

class _MediumSheetState extends State<MediumSheet> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<MediumBloc>(context)
        .add(MediumDataEvent(boardId: widget.boardId));
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
        return BlocBuilder<MediumBloc, MediumState>(builder: (context, state) {
          if (state is MediumLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MediumLoadedState) {
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
                        "Select Medium",
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
                  padding: const EdgeInsets.all(1),
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: state.mediumData.mediummodelData.length,
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
                              return StandardBottomSheet(
                                  mediumId: state
                                      .mediumData.mediummodelData[index].id
                                      .toString());
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
                                      Text(state.mediumData
                                          .mediummodelData[index].name),
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
          } else if (state is MediumErrorState) {
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
