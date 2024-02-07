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
import 'package:task_1/src/screens/home/bloc/search/search_bloc.dart';
import 'package:task_1/src/screens/home/bloc/search/search_event.dart';
import 'package:task_1/src/screens/home/bloc/search/search_state.dart';
import 'package:task_1/src/screens/home/products/product_detail/detail_screen.dart';

class SearchScreen extends StatefulWidget {
  final String keyword;
  const SearchScreen({
    super.key,
    required this.keyword,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCountBloc>(
          create: (context) => HomeCountBloc(),
        ),
        BlocProvider<SearchBloc>(
          create: (BuildContext context) => SearchBloc(),
        ),
        BlocProvider<CartBloc>(
          create: (context) => CartBloc(),
        ),
      ],
      child: SearchDataScreen(
        keyword: widget.keyword,
      ),
    );
  }
}

class SearchDataScreen extends StatefulWidget {
  final String keyword;
  const SearchDataScreen({
    super.key,
    required this.keyword,
  });

  @override
  State<SearchDataScreen> createState() => _SearchDataScreenState();
}

class _SearchDataScreenState extends State<SearchDataScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeCountBloc>(context).add(HomeCountBtnEvent());
    BlocProvider.of<SearchBloc>(context)
        .add(SearchBtnEvent(keyword: widget.keyword));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 50,
        elevation: 0,
        title: const Text('Search'),
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
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state is SearchLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SearchLoadedState) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Showing Results for "${widget.keyword}"',
                        style: const TextStyle(
                          color: Colors.black45,
                          fontSize: 19,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: GridView.builder(
                        itemCount:
                            state.search.searchData.searchProductData.length,
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
                              state.search.searchData.searchProductData[index];

                          // Check if the product has a discount
                          final hasDiscount = productData.discount != "0";

                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailScreen(
                                    productId: state.search.searchData
                                        .searchProductData[index].id
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
                                      state
                                          .search
                                          .searchData
                                          .searchProductData[index]
                                          .productImage,
                                      height: 155,
                                      width: double.infinity,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(6),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          state
                                                  .search
                                                  .searchData
                                                  .searchProductData[index]
                                                  .productName,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          state
                                              .search
                                              .searchData
                                              .searchProductData[index]
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
                                              text: state
                                                  .search
                                                  .searchData
                                                  .searchProductData[index]
                                                  .discount,
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.green),
                                              children: const <TextSpan>[
                                                TextSpan(
                                                  text: '% Off',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w400,
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
                                                    : Colors.blue,
                                              ),
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
                                                state
                                                    .search
                                                    .searchData
                                                    .searchProductData[index]
                                                    .price,
                                                style: const TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.red,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                ),
                                              ),
                                            const Spacer(),
                                            InkWell(
                                              onTap: () {
                                                final isAddedCart = state
                                                        .search
                                                        .searchData
                                                        .searchProductData[
                                                            index]
                                                        .isCart ==
                                                    '1';

                                                if (isAddedCart) {
                                                  BlocProvider.of<CartBloc>(
                                                          context)
                                                      .add(RemoveCartEvent(
                                                    productId: state
                                                        .search
                                                        .searchData
                                                        .searchProductData[
                                                            index]
                                                        .id
                                                        .toString(),
                                                  ));
                                                  _showToast(
                                                      'Cart Item removed');
                                                } else {
                                                  BlocProvider.of<CartBloc>(
                                                          context)
                                                      .add(AddToCartEvent(
                                                    productId: state
                                                        .search
                                                        .searchData
                                                        .searchProductData[
                                                            index]
                                                        .id
                                                        .toString(),
                                                    qty: '1',
                                                  ));
                                                  _showToast(
                                                      'Product added Successfully');
                                                }
                                                setState(() {
                                                  if (isAddedCart) {
                                                    state
                                                        .search
                                                        .searchData
                                                        .searchProductData[
                                                            index]
                                                        .isCart = '0';
                                                  } else {
                                                    state
                                                        .search
                                                        .searchData
                                                        .searchProductData[
                                                            index]
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
                                                            .search
                                                            .searchData
                                                            .searchProductData[
                                                                index]
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
                    ),
                  ),
                ],
              ),
            );
          } else if (state is SearchErrorState) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  //  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Text(
                      'Showing Results for "${widget.keyword}"',
                      style: const TextStyle(
                        color: Colors.black45,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Image.asset(
                      'assets/img/Nodata.jpg',
                      height: 270,
                      width: 255,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      'No Results Found',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Text(
                      'We couldnt find what you search for.',
                      style: TextStyle(
                        color: Colors.black45,
                        fontSize: 16,
                      ),
                    ),
                    const Text(
                      'Try searching again',
                      style: TextStyle(
                        color: Colors.black45,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
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
