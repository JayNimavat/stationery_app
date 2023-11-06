import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_1/src/screens/cart/bloc/cart/cart_bloc.dart';
import 'package:task_1/src/screens/cart/bloc/cart/cart_event.dart';
import 'package:task_1/src/screens/cart/cart.dart';
import 'package:task_1/src/screens/favorites/favorites.dart';
import 'package:task_1/src/constants/colors.dart';
import 'package:task_1/src/screens/home/bloc/features/features_bloc.dart';
import 'package:task_1/src/screens/home/bloc/features/features_event.dart';
import 'package:task_1/src/screens/home/bloc/features/features_state.dart';
import 'package:task_1/src/screens/home/bloc/home_count/bloc_home_count.dart';
import 'package:task_1/src/screens/home/bloc/home_count/event_home_count.dart';
import 'package:task_1/src/screens/home/bloc/home_count/state_home_count.dart';
import 'package:task_1/src/screens/home/products/product_detail/detail_screen.dart';

class Features extends StatefulWidget {
  const Features({super.key});

  @override
  State<Features> createState() => _FeaturesState();
}

class _FeaturesState extends State<Features> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCountBloc>(
          create: (context) => HomeCountBloc(),
        ),
        BlocProvider<FeaturesBloc>(
          create: (context) => FeaturesBloc(),
        ),
        BlocProvider<CartBloc>(
          create: (context) => CartBloc(),
        ),
      ],
      child: const FeaturesScreen(),
    );
  }
}

class FeaturesScreen extends StatefulWidget {
  const FeaturesScreen({super.key});

  @override
  State<FeaturesScreen> createState() => _FeaturesScreenState();
}

class _FeaturesScreenState extends State<FeaturesScreen> {
  final List<Map<String, dynamic>> pdcList = [
    {
      'image': 'assets/img/products/gujarati.jpg',
      'name': 'Gujarati',
      'type': 'Text Book',
      'price': '\u{20B9}${120}',
      'icon': Icons.shopping_cart,
      'school': 'JNV Bhavnagar',
      'board': 'CBSE',
      'medium': 'English',
      'standard': '10',
      'book_name': 'Standard - 10 Gujarati Text Book',
    },
    {
      'image': 'assets/img/products/sanskrit.jpg',
      'name': 'Sanskrit',
      'type': 'Text Book',
      'price': '\u{20B9}${100}',
      'icon': Icons.shopping_cart,
      'school': 'JNV Bhavnagar',
      'board': 'CBSE',
      'medium': 'English',
      'standard': '10',
      'book_name': 'Standard - 10 Sanskrit Text Book',
    },
    {
      'image': 'assets/img/products/hindi.jpg',
      'name': 'Hindi',
      'type': 'Text Book',
      'price': '\u{20B9}${110}',
      'icon': Icons.shopping_cart,
      'school': 'JNV Bhavnagar',
      'board': 'CBSE',
      'medium': 'English',
      'standard': '10',
      'book_name': 'Standard - 10 Hindi Text Book',
    },
    {
      'image': 'assets/img/products/social_science.jpg',
      'name': 'Social Science',
      'type': 'Text Book',
      'price': '\u{20B9}${90}',
      'icon': Icons.shopping_cart,
      'school': 'JNV Bhavnagar',
      'board': 'CBSE',
      'medium': 'English',
      'standard': '10',
      'book_name': 'Standard - 10 Social Science Text Book',
    },
    {
      'image': 'assets/img/products/english.jpeg',
      'name': 'English',
      'type': 'Text Book',
      'price': '\u{20B9}${100}',
      'icon': Icons.shopping_cart,
      'school': 'JNV Bhavnagar',
      'board': 'CBSE',
      'medium': 'English',
      'standard': '10',
      'book_name': 'Standard - 10 English Text Book',
    },
    {
      'image': 'assets/img/products/science.jpeg',
      'name': 'Science',
      'type': 'Text Book',
      'price': '\u{20B9}${120}',
      'icon': Icons.shopping_cart,
      'school': 'JNV Bhavnagar',
      'board': 'CBSE',
      'medium': 'English',
      'standard': '10',
      'book_name': 'Standard - 10 Science Text Book',
    },
  ];

  String? price, sortby;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeCountBloc>(context).add(HomeCountBtnEvent());
    BlocProvider.of<FeaturesBloc>(context).add(FeaturesDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        toolbarHeight: 50,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orangeAccent, Colors.redAccent],
            ),
          ),
        ),
        title: const Text('Features'),
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
                    MaterialPageRoute(builder: (context) => const CartScreen()),
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
      body: BlocBuilder<FeaturesBloc, FeaturesState>(
        builder: (context, state) {
          if (state is FeaturesLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is FeaturesLoadedState) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    GridView.builder(
                      itemCount: state.featuresData.featuresmodelData.length,
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
                            state.featuresData.featuresmodelData[index];
                        final hasDiscount = productData.discount != "0";
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailScreen(
                                  productId: state
                                      .featuresData.featuresmodelData[index].id
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
                                    state.featuresData.featuresmodelData[index]
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
                                                    .featuresData
                                                    .featuresmodelData[index]
                                                    .productName
                                                    .length >
                                                25
                                            ? '${state.featuresData.featuresmodelData[index].productName.substring(0, 25)}...'
                                            : state
                                                .featuresData
                                                .featuresmodelData[index]
                                                .productName,
                                        maxLines: 1,
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        state.featuresData
                                            .featuresmodelData[index].brandName,
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
                                                .featuresData
                                                .featuresmodelData[index]
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
                                              state
                                                  .featuresData
                                                  .featuresmodelData[index]
                                                  .price,
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
                                                      .featuresData
                                                      .featuresmodelData[index]
                                                      .isCart ==
                                                  '1';
                                              if (isAddedCart) {
                                                BlocProvider.of<CartBloc>(
                                                        context)
                                                    .add(RemoveCartEvent(
                                                  productId: state
                                                      .featuresData
                                                      .featuresmodelData[index]
                                                      .id
                                                      .toString(),
                                                ));
                                                _showToast('Cart Item removed');
                                              } else {
                                                BlocProvider.of<CartBloc>(
                                                        context)
                                                    .add(AddToCartEvent(
                                                  productId: state
                                                      .featuresData
                                                      .featuresmodelData[index]
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
                                                      .featuresData
                                                      .featuresmodelData[index]
                                                      .isCart = '0';
                                                } else {
                                                  state
                                                      .featuresData
                                                      .featuresmodelData[index]
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
                                                          .featuresData
                                                          .featuresmodelData[
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
                  ],
                ),
              ),
            );
          } else if (state is FeaturesErrorState) {
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
