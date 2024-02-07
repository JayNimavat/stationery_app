import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_1/src/screens/cart/bloc/cart/cart_bloc.dart';
import 'package:task_1/src/screens/cart/bloc/cart/cart_event.dart';
import 'package:task_1/src/screens/cart/cart.dart';
import 'package:task_1/src/screens/favorites/favorites.dart';
import 'package:task_1/src/screens/home/bloc/home_count/bloc_home_count.dart';
import 'package:task_1/src/screens/home/bloc/home_count/event_home_count.dart';
import 'package:task_1/src/screens/home/bloc/home_count/state_home_count.dart';
import 'package:task_1/src/screens/home/bloc/today_deal/todaydeal_bloc.dart';
import 'package:task_1/src/screens/home/bloc/today_deal/todaydeal_event.dart';
import 'package:task_1/src/screens/home/bloc/today_deal/todaydeal_state.dart';
import 'package:task_1/src/screens/home/products/product_detail/detail_screen.dart';
import 'package:task_1/src/constants/colors.dart';

class TodayDealScreen extends StatefulWidget {
  const TodayDealScreen({super.key});

  @override
  State<TodayDealScreen> createState() => _TodayDealScreenState();
}

class _TodayDealScreenState extends State<TodayDealScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCountBloc>(
          create: (context) => HomeCountBloc(),
        ),
        BlocProvider<TodaydealBloc>(
          create: (context) => TodaydealBloc(),
        ),
        BlocProvider<CartBloc>(
          create: (context) => CartBloc(),
        ),
      ],
      child: const TodayDeal(),
    );
  }
}

class TodayDeal extends StatefulWidget {
  const TodayDeal({
    Key? key,
  }) : super(key: key);

  @override
  State<TodayDeal> createState() => _TodayDealState();
}

class _TodayDealState extends State<TodayDeal> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeCountBloc>(context).add(HomeCountBtnEvent());
    BlocProvider.of<TodaydealBloc>(context).add(TodaydealDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        toolbarHeight: 50,
        elevation: 0,
        title: const Text('Today Deal'),
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
      body: BlocBuilder<TodaydealBloc, TodaydealState>(
        builder: (context, state) {
          if (state is TodaydealInitialState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TodaydealLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TodaydealLoadedState) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    GridView.builder(
                      itemCount: state.todayData.todaydealData.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 14.0,
                        crossAxisSpacing: 10.0,
                        mainAxisExtent: 247,
                      ),
                      itemBuilder: (context, index) {
                        final productData =
                            state.todayData.todaydealData[index];
                        final hasDiscount = productData.discount != "0";

                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailScreen(
                                  productId: state
                                      .todayData.todaydealData[index].id
                                      .toString(),
                                ),
                              ),
                            );
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height,
                            margin:
                                const EdgeInsets.only(left: 4.0, right: 4.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade400,
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(5.0),
                                    topRight: Radius.circular(5.0),
                                  ),
                                  child: Image.network(
                                    state.todayData.todaydealData[index]
                                        .productImage,
                                    height: 155,
                                    width: double.infinity,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        state
                                                .todayData
                                                .todaydealData[index]
                                                .productName,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        state.todayData.todaydealData[index]
                                            .brandName,
                                        style: const TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black45,
                                        ),
                                      ),
                                      if (hasDiscount)
                                        RichText(
                                          text: TextSpan(
                                            text: state.todayData
                                                .todaydealData[index].discount,
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.green),
                                            children: const <TextSpan>[
                                              TextSpan(
                                                text: '% Off',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.green),
                                              ),
                                            ],
                                          ),
                                        ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.currency_rupee_outlined,
                                            size: 16,
                                            color: Colors.blue,
                                          ),
                                          Text(
                                            hasDiscount
                                                ? productData.discountPrice
                                                : productData.price,
                                            style: TextStyle(
                                                fontSize: hasDiscount ? 16 : 15,
                                                fontWeight: FontWeight.w400,
                                                color: hasDiscount
                                                    ? Colors.blue
                                                    : Colors.blue),
                                          ),
                                          const SizedBox(
                                            width: 3,
                                          ),
                                          if (hasDiscount)
                                            const Icon(
                                              Icons.currency_rupee_outlined,
                                              size: 13,
                                              color: Colors.red,
                                            ),
                                          if (hasDiscount)
                                            Text(
                                              state.todayData
                                                  .todaydealData[index].price,
                                              style: const TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.red,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                              ),
                                            ),
                                          const Spacer(),
                                          InkWell(
                                            onTap: () {
                                              final isAddedCart = state
                                                      .todayData
                                                      .todaydealData[index]
                                                      .isCart ==
                                                  '1';

                                              if (isAddedCart) {
                                                BlocProvider.of<CartBloc>(
                                                        context)
                                                    .add(RemoveCartEvent(
                                                  productId: state.todayData
                                                      .todaydealData[index].id
                                                      .toString(),
                                                ));
                                                _showToast('Cart Item removed');
                                              } else {
                                                BlocProvider.of<CartBloc>(
                                                        context)
                                                    .add(AddToCartEvent(
                                                  productId: state.todayData
                                                      .todaydealData[index].id
                                                      .toString(),
                                                  qty: '1',
                                                ));
                                                _showToast(
                                                    'Product added Successfully');
                                              }
                                              setState(() {
                                                if (isAddedCart) {
                                                  state
                                                      .todayData
                                                      .todaydealData[index]
                                                      .isCart = '0';
                                                } else {
                                                  state
                                                      .todayData
                                                      .todaydealData[index]
                                                      .isCart = '1';
                                                }
                                              });
                                              BlocProvider.of<HomeCountBloc>(
                                                      context)
                                                  .add(HomeCountBtnEvent());
                                            },
                                            child: Icon(
                                              Icons.shopping_cart,
                                              color: state
                                                          .todayData
                                                          .todaydealData[index]
                                                          .isCart ==
                                                      '1'
                                                  ? Colors.blue
                                                  : Colors.black45,
                                              size: 22,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          } else if (state is TodaydealErrorState) {
            return Center(
              child: Text(state.error),
            );
          }
          return Container();
        },
      ),
    );
  }
}

void _showToast(String message) {
  // Show a toast message
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.black45,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
