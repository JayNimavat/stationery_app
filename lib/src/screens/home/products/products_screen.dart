import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_1/src/screens/cart/bloc/cart/cart_bloc.dart';
import 'package:task_1/src/screens/cart/bloc/cart/cart_event.dart';
import 'package:task_1/src/screens/favorites/favorites.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_1/src/screens/home/bloc/allproduct/allproduct_bloc.dart';
import 'package:task_1/src/screens/home/bloc/allproduct/allproduct_event.dart';
import 'package:task_1/src/screens/home/bloc/allproduct/allproduct_state.dart';
import 'package:task_1/src/constants/colors.dart';
import 'package:task_1/src/screens/cart/cart.dart';
import 'package:task_1/src/screens/home/bloc/home_count/bloc_home_count.dart';
import 'package:task_1/src/screens/home/bloc/home_count/event_home_count.dart';
import 'package:task_1/src/screens/home/bloc/home_count/state_home_count.dart';
import 'package:task_1/src/screens/home/bloc/product_detail/bloc_product_detail.dart';
import 'package:task_1/src/screens/home/products/product_detail/detail_screen.dart';

class ProductsWidget extends StatefulWidget {
  const ProductsWidget({Key? key}) : super(key: key);

  @override
  State<ProductsWidget> createState() => _ProductsWidgetState();
}

class _ProductsWidgetState extends State<ProductsWidget> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<HomeCountBloc>(
        create: (context) => HomeCountBloc(),
      ),
      BlocProvider<AllproductBloc>(
        create: (BuildContext context) => AllproductBloc(),
      ),
      BlocProvider<ProductDetailBloc>(
        create: (context) => ProductDetailBloc(),
      ),
      BlocProvider<CartBloc>(
        create: (context) => CartBloc(),
      ),
    ], child: const ProductsScreen());
  }
}

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  int currentPage = 1;
  final int pageSize = 10;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeCountBloc>(context).add(HomeCountBtnEvent());
    BlocProvider.of<AllproductBloc>(context).add(AllproductdataEvent(
      filterPrice: '', filterSortBy: ''));
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
      body: BlocBuilder<AllproductBloc, AllproductState>(
          builder: (context, state) {
            if (state is AllproductLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is AllproductLoadedState) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return const FilterDialogBox();
                              },
                            ).then((value) {
                              if (value != null) {
                                BlocProvider.of<AllproductBloc>(context).add(
                                  AllproductdataEvent(
                                    filterPrice: value[0],
                                    filterSortBy: value[1],
                                  ),
                                );
                              }
                            });
                          },
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: 30,
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/img/filter.png',
                                  color: Colors.blue,
                                  height: 25,
                                  width: 23,
                                ),
                                const Text(
                                  'Filter',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 21,
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
                          itemCount: state.productData.allproductData.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 14.0,
                            crossAxisSpacing: 10.0,
                            mainAxisExtent: 247,
                          ),
                          itemBuilder: (BuildContext context, index)  {
                            final productData =
                            state.productData.allproductData[index];

                            // Check if the product has a discount
                            final hasDiscount = productData.discount != "0";

                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductDetailScreen(
                                      productId: state
                                          .productData.allproductData[index].id
                                          .toString(),
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                height: MediaQuery.of(context).size.height,
                                margin: const EdgeInsets.only(
                                  left: 4.0,
                                  right: 4.0,
                                ),
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
                                        state.productData.allproductData[index]
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
                                            state.productData.allproductData[index]
                                                .productName,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: const TextStyle(
                                              fontSize: 13,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            state.productData.allproductData[index]
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
                                                text: state.productData
                                                    .allproductData[index].discount,
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
                                          if (hasDiscount)
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
                                              if (hasDiscount)
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
                                                  state.productData
                                                      .allproductData[index].price,
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
                                                      .productData
                                                      .allproductData[index]
                                                      .isCart ==
                                                      '1';

                                                  if (isAddedCart) {
                                                    BlocProvider.of<CartBloc>(
                                                        context)
                                                        .add(RemoveCartEvent(
                                                      productId: state.productData
                                                          .allproductData[index].id
                                                          .toString(),
                                                    ));
                                                    _showToast('Cart Item removed');
                                                  } else {
                                                    BlocProvider.of<CartBloc>(
                                                        context)
                                                        .add(AddToCartEvent(
                                                      productId: state.productData
                                                          .allproductData[index].id
                                                          .toString(),
                                                      qty: '1',
                                                    ));
                                                    _showToast(
                                                        'Product added Successfully');
                                                  }
                                                  setState(() {
                                                    if (isAddedCart) {
                                                      state
                                                          .productData
                                                          .allproductData[index]
                                                          .isCart = '0';
                                                    } else {
                                                      state
                                                          .productData
                                                          .allproductData[index]
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
                                                      .productData
                                                      .allproductData[index]
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
            } else if (state is AllproductErrorState) {
              return Center(
                child: Text(state.error),
              );
            }
            return Container();
          }),
    );
  }
}

class FilterDialogBox extends StatefulWidget {
  const FilterDialogBox({super.key});

  @override
  State<FilterDialogBox> createState() => _FilterDialogBoxState();
}

class _FilterDialogBoxState extends State<FilterDialogBox> {
  String price = "";
  String sortby = "";

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      insetPadding: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: CircleAvatar(
                backgroundColor: Colors.blue[200],
                radius: 12,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.close,
                    color: Colors.blue[600],
                  ),
                ),
              ),
            ),
            const Align(
              alignment: Alignment.topCenter,
              child: Text(
                'Sort and Filter',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            const Divider(
              thickness: 1,
            ),
            const Text(
              'Price',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            RadioListTile(
              dense: true,
              visualDensity: VisualDensity.compact,
              title: const Text('0 - 100'),
              value: '1',
              groupValue: price,
              onChanged: (value) {
                setState(() {
                  price = value.toString();
                });
              },
            ),
            RadioListTile(
              dense: true,
              visualDensity: VisualDensity.compact,
              title: const Text('100 - 300'),
              value: '2',
              groupValue: price,
              onChanged: (value) {
                setState(() {
                  price = value.toString();
                });
              },
            ),
            RadioListTile(
              dense: true,
              visualDensity: VisualDensity.compact,
              title: const Text('300 - 500'),
              value: '3',
              groupValue: price,
              onChanged: (value) {
                setState(() {
                  price = value.toString();
                });
              },
            ),
            RadioListTile(
              dense: true,
              visualDensity: VisualDensity.compact,
              title: const Text('500 above'),
              value: '4',
              groupValue: price,
              onChanged: (value) {
                setState(() {
                  price = value.toString();
                });
              },
            ),
            const Divider(
              thickness: 1,
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              'Sort by',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            RadioListTile(
              dense: true,
              visualDensity: VisualDensity.compact,
              title: const Text('Popularity'),
              value: '1',
              groupValue: sortby,
              onChanged: (value) {
                setState(() {
                  sortby = value.toString();
                });
              },
            ),
            RadioListTile(
              dense: true,
              visualDensity: VisualDensity.compact,
              title: const Text('Newest First'),
              value: '2',
              groupValue: sortby,
              onChanged: (value) {
                setState(() {
                  sortby = value.toString();
                });
              },
            ),
            RadioListTile(
              dense: true,
              visualDensity: VisualDensity.compact,
              title: const Text('Features Product'),
              value: '3',
              groupValue: sortby,
              onChanged: (value) {
                setState(() {
                  sortby = value.toString();
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue,
                    elevation: 0,
                    side: const BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Clear All',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    elevation: 0,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop([price, sortby]);
                  },
                  child: const Text(
                    'Apply',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
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