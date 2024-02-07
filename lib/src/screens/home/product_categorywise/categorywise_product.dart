import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_1/src/constants/colors.dart';
import 'package:task_1/src/screens/cart/bloc/cart/cart_bloc.dart';
import 'package:task_1/src/screens/cart/bloc/cart/cart_event.dart';
import 'package:task_1/src/screens/cart/cart.dart';
import 'package:task_1/src/screens/favorites/favorites.dart';
import 'package:task_1/src/screens/home/bloc/all_add_to_cart/bloc_all_add_cart.dart';
import 'package:task_1/src/screens/home/bloc/home_count/bloc_home_count.dart';
import 'package:task_1/src/screens/home/bloc/home_count/event_home_count.dart';
import 'package:task_1/src/screens/home/bloc/home_count/state_home_count.dart';
import 'package:task_1/src/screens/home/bloc/product_categorywise/bloc_catwise_product.dart';
import 'package:task_1/src/screens/home/bloc/product_categorywise/event_catwise_product.dart';
import 'package:task_1/src/screens/home/bloc/product_categorywise/state_catwise_product.dart';
import 'package:task_1/src/screens/home/product_categorywise/bottomsheet/add_all_bottomsheet.dart';
import 'package:task_1/src/screens/home/products/product_detail/detail_screen.dart';

class CategorywiseProduct extends StatefulWidget {
  final String standardId;
  const CategorywiseProduct({super.key, required this.standardId});

  @override
  State<CategorywiseProduct> createState() => _CategorywiseProductState();
}

class _CategorywiseProductState extends State<CategorywiseProduct> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCountBloc>(
          create: (context) => HomeCountBloc(),
        ),
        BlocProvider<CatwiseProductBloc>(
          create: (context) => CatwiseProductBloc(),
        ),
        BlocProvider<CartBloc>(
          create: (context) => CartBloc(),
        ),
        BlocProvider<AllAddToCartBloc>(
          create: (context) => AllAddToCartBloc(),
        ),
      ],
      child: CatwiseProduct(
        standardId: widget.standardId,
      ),
    );
  }
}

class CatwiseProduct extends StatefulWidget {
  final String standardId;
  const CatwiseProduct({super.key, required this.standardId});

  @override
  State<CatwiseProduct> createState() => _CatwiseProductState();
}

class _CatwiseProductState extends State<CatwiseProduct> {
  Set<String> selectedProductIds = <String>{};
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeCountBloc>(context).add(HomeCountBtnEvent());
    BlocProvider.of<CatwiseProductBloc>(context)
        .add(CatwiseProductDataEvent(standardId: widget.standardId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        toolbarHeight: 50,
        elevation: 0,
        title: const Text('Products'),
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
      body: BlocBuilder<CatwiseProductBloc, CatwiseProductState>(
        builder: (context, state) {
          if (state is CatwiseProductLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CatwiseProductLoadedState) {
            if (state.catwiseProductData.catwiseProductModelData.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context2) {
                                  return AddAllToCartSheet(
                                    standardId: widget.standardId,
                                  );
                                });
                          },
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: 30,
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.shopping_cart,
                                  color: Colors.blue,
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  'Add All',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: GridView.builder(
                          itemCount: state.catwiseProductData
                              .catwiseProductModelData.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 14.0,
                            crossAxisSpacing: 10.0,
                            mainAxisExtent: 245,
                          ),
                          itemBuilder: (BuildContext context, index) {
                            final productData = state.catwiseProductData
                                .catwiseProductModelData[index];
                            final hasDiscount = productData.discount != "0";

                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ProductDetailScreen(
                                      productId: state.catwiseProductData
                                          .catwiseProductModelData[index].id
                                          .toString(),
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                height: MediaQuery.of(context).size.height,
                                margin: const EdgeInsets.only(
                                    left: 4.0, right: 4.0),
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
                                            .catwiseProductData
                                            .catwiseProductModelData[index]
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
                                                    .catwiseProductData
                                                    .catwiseProductModelData[
                                                        index]
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
                                                .catwiseProductData
                                                .catwiseProductModelData[index]
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
                                                    .catwiseProductData
                                                    .catwiseProductModelData[
                                                        index]
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
                                                    fontSize:
                                                        hasDiscount ? 16 : 15,
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
                                                  state
                                                      .catwiseProductData
                                                      .catwiseProductModelData[
                                                          index]
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
                                                          .catwiseProductData
                                                          .catwiseProductModelData[
                                                              index]
                                                          .isCart ==
                                                      '1';
                                                  if (isAddedCart) {
                                                    BlocProvider.of<CartBloc>(
                                                            context)
                                                        .add(RemoveCartEvent(
                                                      productId: state
                                                          .catwiseProductData
                                                          .catwiseProductModelData[
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
                                                          .catwiseProductData
                                                          .catwiseProductModelData[
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
                                                          .catwiseProductData
                                                          .catwiseProductModelData[
                                                              index]
                                                          .isCart = '0';
                                                    } else {
                                                      state
                                                          .catwiseProductData
                                                          .catwiseProductModelData[
                                                              index]
                                                          .isCart = '1';
                                                    }
                                                  });
                                                  BlocProvider.of<
                                                              HomeCountBloc>(
                                                          context)
                                                      .add(HomeCountBtnEvent());
                                                },
                                                child: Icon(
                                                  Icons.shopping_cart,
                                                  color: state
                                                              .catwiseProductData
                                                              .catwiseProductModelData[
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
            } else {
              return const Center(
                child: Text(
                  'Data Not Found...!',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              );
            }
          } else if (state is CatwiseProductErrorState) {
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
