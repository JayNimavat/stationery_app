import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_1/src/constants/colors.dart';
import 'package:task_1/src/screens/favorites/bloc/save_wish/bloc_save_wish.dart';
import 'package:task_1/src/screens/favorites/bloc/save_wish/event_save_wish.dart';
import 'package:task_1/src/screens/favorites/bloc/wish_list/bloc_wish_list.dart';
import 'package:task_1/src/screens/favorites/bloc/wish_list/event_wish_list.dart';
import 'package:task_1/src/screens/favorites/bloc/wish_list/state_wish_list.dart';
import 'package:task_1/src/screens/favorites/bottomsheet.dart';
import 'package:task_1/src/screens/home/products/product_detail/detail_screen.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WishListBloc>(
          create: (BuildContext context) => WishListBloc(),
        ),
        BlocProvider<WishBloc>(
          create: (BuildContext context) => WishBloc(),
        ),
      ],
      child: const FavoritesScreen(),
    );
  }
}

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<WishListBloc>(context).add(WishListDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        toolbarHeight: 50,
        elevation: 0,
        title: const Text('Favorites'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orangeAccent, Colors.redAccent],
            ),
          ),
        ),
      ),
      body: BlocBuilder<WishListBloc, WishListState>(builder: (context, state) {
        if (state is WishListInitialState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is WishListLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is WishListLoadedState) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 5.0, right: 8.0),
              child: ListView.builder(
                itemCount: state.wishListData.wishListModelData.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(state.wishListData.wishListModelData[index]
                        .wishListProductData.productName
                        .toString()),
                    resizeDuration: const Duration(milliseconds: 200),
                    dismissThresholds: const <DismissDirection, double>{},
                    movementDuration: const Duration(milliseconds: 200),
                    crossAxisEndOffset: 0.0,
                    direction: DismissDirection.startToEnd,
                    confirmDismiss: (DismissDirection direction) async {
                      return await showModalBottomSheet(
                        context: context,
                        //  barrierColor: Colors.transparent,
                        builder: (context2) {
                          return RemoveWishBottomSheet(
                            wishlistId: state
                                .wishListData.wishListModelData[index].id
                                .toString(),
                            productImage: state
                                .wishListData
                                .wishListModelData[index]
                                .wishListProductData
                                .productImage,
                            productName: state
                                .wishListData
                                .wishListModelData[index]
                                .wishListProductData
                                .productName,
                            id: state.wishListData.wishListModelData[index].id
                                .toString(),
                            onItemRemoved: (bool removed) {
                              if (removed) {
                                BlocProvider.of<WishListBloc>(context).add(WishListDataEvent());
                              }
                            },
                          );
                        },
                      );
                    },
                    background: Container(
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Colors.red,
                      ),
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    onDismissed: (direction) {
                      BlocProvider.of<WishBloc>(context).add(RemoveWishEvent(
                          wishlistId: state
                              .wishListData.wishListModelData[index].id
                              .toString()));
                      BlocProvider.of<WishListBloc>(context)
                          .add(WishListDataEvent());
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 1,
                      height: 145,
                      margin: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11.0),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ProductDetailScreen(
                                      productId: state.wishListData
                                          .wishListModelData[index].productId
                                          .toString()),
                                ));
                              },
                              child: Image.network(
                                state.wishListData.wishListModelData[index]
                                    .wishListProductData.productImage,
                                height: 125,
                                width: 95,
                                fit: BoxFit.fill,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  state
                                              .wishListData
                                              .wishListModelData[index]
                                              .wishListProductData
                                              .productName
                                              .length >
                                          25
                                      ? '${state.wishListData.wishListModelData[index].wishListProductData.productName.substring(0, 25)}...'
                                      : state
                                          .wishListData
                                          .wishListModelData[index]
                                          .wishListProductData
                                          .productName,
                                  style: const TextStyle(fontSize: 14),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  state.wishListData.wishListModelData[index]
                                      .wishListProductData.brandName,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black45,
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.currency_rupee_outlined,
                                      size: 15,
                                      color: Colors.blue,
                                    ),
                                    Text(
                                      state
                                                  .wishListData
                                                  .wishListModelData[index]
                                                  .wishListProductData
                                                  .discount ==
                                              "0"
                                          ? state
                                              .wishListData
                                              .wishListModelData[index]
                                              .wishListProductData
                                              .price
                                          : state
                                              .wishListData
                                              .wishListModelData[index]
                                              .wishListProductData
                                              .discountPrice,
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.blue),
                                    ),
                                    const SizedBox(
                                      width: 3,
                                    ),
                                    if (state
                                            .wishListData
                                            .wishListModelData[index]
                                            .wishListProductData
                                            .discount !=
                                        "0")
                                      const Icon(
                                        Icons.currency_rupee_outlined,
                                        size: 13,
                                        color: Colors.red,
                                      ),
                                    if (state
                                            .wishListData
                                            .wishListModelData[index]
                                            .wishListProductData
                                            .discount !=
                                        "0")
                                      Text(
                                        state
                                            .wishListData
                                            .wishListModelData[index]
                                            .wishListProductData
                                            .price,
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.red,
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                      ),
                                    const SizedBox(width: 3),
                                    if (state
                                            .wishListData
                                            .wishListModelData[index]
                                            .wishListProductData
                                            .discount !=
                                        "0")
                                      RichText(
                                        text: TextSpan(
                                          text: state
                                              .wishListData
                                              .wishListModelData[index]
                                              .wishListProductData
                                              .discount,
                                          style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.green),
                                          children: const <TextSpan>[
                                            TextSpan(
                                              text: '% Off',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.green),
                                            ),
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                            const Spacer(),
                            Align(
                              alignment: Alignment.topRight,
                              child: InkWell(
                                onTap: () async {
                                  return await showModalBottomSheet(
                                    context: context,
                                    //  barrierColor: Colors.transparent,
                                    builder: (context2) {
                                      return RemoveWishBottomSheet(
                                        wishlistId: state.wishListData
                                            .wishListModelData[index].id
                                            .toString(),
                                        productImage: state
                                            .wishListData
                                            .wishListModelData[index]
                                            .wishListProductData
                                            .productImage,
                                        productName: state
                                            .wishListData
                                            .wishListModelData[index]
                                            .wishListProductData
                                            .productName,
                                        id: state.wishListData
                                            .wishListModelData[index].id
                                            .toString(),
                                        onItemRemoved: (bool removed) {
                                          if (removed) {
                                            BlocProvider.of<WishListBloc>(context).add(WishListDataEvent());
                                          }
                                        },
                                      );
                                    },
                                  );
                                },
                                child: const Icon(Icons.close),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        } else if (state is WishListErrorState) {
          return const Center(
            child: Text(
              'DATA NOT FOUND',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
            ),
          );
        }
        return Container();
      }),
    );
  }
}
