import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/category/bloc/board/bloc_board_category.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/category/bloc/board/event_board_category.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/category/bloc/board/state_board_category.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/category/bloc/medium/bloc_medium_category.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/category/bloc/medium/event_medium_category.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/category/bloc/medium/state_medium_category.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/category/bloc/school/bloc_school_category.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/category/bloc/school/event_school_category.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/category/bloc/school/state_school_category.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/category/bloc/standard/bloc_standard_category.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/category/bloc/standard/event_standard_category.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/category/bloc/standard/state_standard_category.dart';
import 'package:task_1/src/screens/home/bloc/home_count/bloc_home_count.dart';
import 'package:task_1/src/screens/home/bloc/home_count/event_home_count.dart';
import 'package:task_1/src/screens/home/bloc/home_count/state_home_count.dart';
import 'package:task_1/src/screens/home/product_categorywise/categorywise_product.dart';
import 'package:task_1/src/constants/colors.dart';
import 'package:task_1/src/screens/cart/cart.dart';
import 'package:task_1/src/screens/favorites/favorites.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCountBloc>(
          create: (context) => HomeCountBloc(),
        ),
        BlocProvider<SchoolCategoryBloc>(
          create: (context) => SchoolCategoryBloc(),
        ),
        BlocProvider<BoardCategoryBloc>(
          create: (context) => BoardCategoryBloc(),
        ),
        BlocProvider<MediumCategoryBloc>(
          create: (context) => MediumCategoryBloc(),
        ),
        BlocProvider<StandardCategoryBloc>(
          create: (context) => StandardCategoryBloc(),
        ),
      ],
      child: const Category(),
    );
  }
}

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  bool _isTappedSchool = false;
  bool _isTappedBoard = false;
  bool _isTappedMedium = false;
  bool _isTappedStandard = false;

  int _tappedIndex = -1;
  int _tapedIndex = -1;

  int _selectedSchoolId = -1;
  int _selectedBoardId = -1;
  int _selectedMediumId = -1;
  int _selectedStandardId = -1;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeCountBloc>(context).add(HomeCountBtnEvent());
    BlocProvider.of<SchoolCategoryBloc>(context).add(
        SchoolCategoryBtnEvent(selectedSchoolId: _selectedSchoolId.toString()));
    BlocProvider.of<BoardCategoryBloc>(context).add(
        BoardCategoryBtnEvent(selectedBoardId: _selectedBoardId.toString()));
    BlocProvider.of<MediumCategoryBloc>(context).add(
        MediumCategoryBtnEvent(selectedMediumId: _selectedMediumId.toString()));
    BlocProvider.of<StandardCategoryBloc>(context).add(StandardCategoryBtnEvent(
        selectedStandardId: _selectedStandardId.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        toolbarHeight: 50,
        elevation: 0,
        title: const Text('Category'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orangeAccent, Colors.redAccent],
            ),
          ),
        ),
        actions: <Widget>[
          Stack(
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.favorite),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const Favorites(),
                    ),
                  );
                },
              ),
              Positioned(
                right: 5,
                top: 6,
                child: BlocBuilder<HomeCountBloc, HomeCountState>(
                  builder: (context, state) {
                    if (state is HomeCountLoadedState) {
                      if (state.homeCountData.homeCountModelData.favoriteCount
                              .toString() ==
                          '0') {
                        return Container();
                      } else {
                        return Badge(
                          backgroundColor: Colors.yellow,
                          textColor: Colors.black,
                          label: Text(
                            state.homeCountData.homeCountModelData.favoriteCount
                                .toString(),
                          ),
                        );
                      }
                    } else if (state is HomeCountErrorState) {
                      return Center(
                        child: Text(state.error),
                      );
                    }
                    return Container();
                  },
                ),
              ),
            ],
          ),
          Stack(
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const CartScreen(),
                    ),
                  );
                },
              ),
              Positioned(
                right: 5,
                top: 6,
                child: BlocBuilder<HomeCountBloc, HomeCountState>(
                  builder: (context, state) {
                    if (state is HomeCountLoadedState) {
                      if (state.homeCountData.homeCountModelData.cartCount
                              .toString() ==
                          '0') {
                        return Container();
                      } else {
                        return Badge(
                          backgroundColor: Colors.yellow,
                          textColor: Colors.black,
                          label: Text(
                            state.homeCountData.homeCountModelData.cartCount
                                .toString(),
                          ),
                        );
                      }
                    } else if (state is HomeCountErrorState) {
                      return Center(
                        child: Text(state.error),
                      );
                    }
                    return Container();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              const Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'School',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              // SCHOOL LIST HERE
              SizedBox(
                height: 240,
                width: 200,
                child: BlocBuilder<SchoolCategoryBloc, SchoolCategoryState>(
                  builder: (context, state) {
                    if (state is SchoolCategoryLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is SchoolCategoryLoadedState) {
                      return ListView.builder(
                        itemCount: state
                            .schoolCategoryData.schoolCategoryModelData.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                _selectedSchoolId = state.schoolCategoryData
                                    .schoolCategoryModelData[index].id;
                                _isTappedSchool = !_isTappedSchool;
                              });
                            },
                            child: Container(
                              height: 240,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: _isTappedSchool
                                    ? Colors.blue
                                    : Colors.white,
                                border: Border.all(
                                  color: Colors.black26,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Image.network(
                                    state.schoolCategoryData
                                        .schoolCategoryModelData[index].image,
                                    height: 180,
                                    width: 160,
                                  ),
                                  Text(
                                    state.schoolCategoryData
                                        .schoolCategoryModelData[index].name,
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: _isTappedSchool
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else if (state is SchoolCategoryErrorState) {
                      return Center(
                        child: Text(state.error),
                      );
                    }
                    return Container();
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              _isTappedSchool
                  ? Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        const Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Education Board',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // BOARD LIST HERE
                        SizedBox(
                          height: 250,
                          width: 200,
                          child: BlocBuilder<BoardCategoryBloc,
                              BoardCategoryState>(
                            builder: (context, state) {
                              if (state is BoardCategoryLoadingState) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (state is BoardCategoryLoadedState) {
                                return ListView.builder(
                                  itemCount: state.boardCategoryData
                                      .boardCategoryModelData.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        setState(() {
                                          _selectedBoardId = state
                                              .boardCategoryData
                                              .boardCategoryModelData[index]
                                              .id;
                                          _isTappedBoard = !_isTappedBoard;
                                        });
                                      },
                                      child: Container(
                                        height: 240,
                                        width: 200,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: _isTappedBoard
                                              ? Colors.blue
                                              : Colors.white,
                                          border: Border.all(
                                            color: Colors.black26,
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Image.network(
                                              state
                                                  .boardCategoryData
                                                  .boardCategoryModelData[index]
                                                  .image,
                                              height: 180,
                                              width: 160,
                                            ),
                                            Text(
                                              state
                                                  .boardCategoryData
                                                  .boardCategoryModelData[index]
                                                  .name,
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: _isTappedBoard
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              } else if (state is BoardCategoryErrorState) {
                                return Center(
                                  child: Text(state.error),
                                );
                              }
                              return Container();
                            },
                          ),
                        ),
                        //  BoardCategory(),
                      ],
                    )
                  : Container(),
              _isTappedBoard
                  ? Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        const Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Medium',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // horizontal list
                        SizedBox(
                          height: 55,
                          width: MediaQuery.of(context).size.width,
                          child: BlocBuilder<MediumCategoryBloc,
                              MediumCategoryState>(
                            builder: (context, state) {
                              if (state is MediumCategoryLoadingState) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (state is MediumCategoryLoadedState) {
                                return ListView.builder(
                                  itemCount: state.mediumCategoryData
                                      .mediumCategoryModelData.length,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        setState(() {
                                          _selectedMediumId = state
                                              .mediumCategoryData
                                              .mediumCategoryModelData[index]
                                              .id;
                                          _tappedIndex = index;
                                          _isTappedMedium = !_isTappedMedium;
                                        });
                                      },
                                      child: Container(
                                        height: 50,
                                        width: 150,
                                        margin: const EdgeInsets.all(5.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: _tappedIndex == index
                                              ? Colors.blue
                                              : Colors.white,
                                          border: Border.all(
                                            color: Colors.black26,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            state
                                                .mediumCategoryData
                                                .mediumCategoryModelData[index]
                                                .name,
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: _tappedIndex == index
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              } else if (state is MediumCategoryErrorState) {
                                return Center(
                                  child: Text(state.error),
                                );
                              }
                              return Container();
                            },
                          ),
                        ),
                      ],
                    )
                  : Container(),
              _isTappedMedium
                  ? Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        const Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Standard',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // STANDARD LIST HERE

                        SizedBox(
                          height: 55,
                          width: MediaQuery.of(context).size.width,
                          child: BlocBuilder<StandardCategoryBloc,
                              StandardCategoryState>(
                            builder: (context, state) {
                              if (state is StandardCategoryLoadingState) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (state is StandardCategoryLoadedState) {
                                return ListView.builder(
                                  itemCount: state.standardCategoryData
                                      .standardCategoryModelData.length,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        setState(() {
                                          _selectedStandardId = state
                                              .standardCategoryData
                                              .standardCategoryModelData[index]
                                              .id;
                                          _tapedIndex = index;
                                          _isTappedStandard =
                                              !_isTappedStandard;
                                        });
                                      },
                                      child: Container(
                                        height: 55,
                                        width: 100,
                                        margin: const EdgeInsets.all(5.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: _tapedIndex == index
                                              ? Colors.blue
                                              : Colors.white,
                                          border: Border.all(
                                            color: Colors.black26,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            state
                                                .standardCategoryData
                                                .standardCategoryModelData[
                                                    index]
                                                .name,
                                            style: TextStyle(
                                              fontSize: 17,
                                              color: _tapedIndex == index
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              } else if (state is StandardCategoryErrorState) {
                                return Center(
                                  child: Text(state.error),
                                );
                              }
                              return Container();
                            },
                          ),
                        ),
                      ],
                    )
                  : Container(),
              _isTappedStandard
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 55,
                          width: MediaQuery.of(context).size.width,
                          child: BlocBuilder<StandardCategoryBloc,
                              StandardCategoryState>(
                            builder: (context, state) {
                              if (state is StandardCategoryLoadingState) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (state is StandardCategoryLoadedState) {
                                return ListView.builder(
                                  itemCount: 1,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CategorywiseProduct(
                                              standardId: _selectedStandardId
                                                  .toString(),
                                            ),
                                          ),
                                        );
                                      },
                                      child: const Text(
                                        'Done',
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 20,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              } else if (state is StandardCategoryErrorState) {
                                return Center(
                                  child: Text(state.error),
                                );
                              }
                              return Container();
                            },
                          ),
                        ),
                      ],
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
