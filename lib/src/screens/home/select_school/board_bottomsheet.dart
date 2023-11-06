import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_1/src/screens/home/bloc/select_school/board/board_bloc.dart';
import 'package:task_1/src/screens/home/bloc/select_school/board/board_event.dart';
import 'package:task_1/src/screens/home/bloc/select_school/board/board_state.dart';
import 'package:task_1/src/screens/home/select_school/medium_bottomsheet.dart';

class BoardBottomSheet extends StatefulWidget {
  final String schoolId;
  const BoardBottomSheet({super.key, required this.schoolId});

  @override
  State<BoardBottomSheet> createState() => _BoardBottomSheetState();
}

class _BoardBottomSheetState extends State<BoardBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<BoardBloc>(
      create: (context) => BoardBloc(),
      child: BoardSheet(
        schoolId: widget.schoolId,
      ),
    );
  }
}

class BoardSheet extends StatefulWidget {
  final String schoolId;
  const BoardSheet({super.key, required this.schoolId});

  @override
  State<BoardSheet> createState() => _BoardSheetState();
}

class _BoardSheetState extends State<BoardSheet> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<BoardBloc>(context).add(
      BoardDataEvent(
        schoolId: widget.schoolId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.37, // Adjust this value as needed
      minChildSize: 0.27,
      maxChildSize: 0.37,
      snap: true,
      builder: (context, scrollController) {
        return BlocBuilder<BoardBloc, BoardState>(builder: (context, state) {
          if (state is BoardLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is BoardLoadedState) {
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
                        "Select Board",
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
                    itemCount: state.boardData.boardmodelData.length,
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
                              return MediumBottomSheet(
                                boardId: state
                                    .boardData.boardmodelData[index].id
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
                                      Text(state.boardData.boardmodelData[index]
                                          .name),
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
          } else if (state is BoardErrorState) {
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
