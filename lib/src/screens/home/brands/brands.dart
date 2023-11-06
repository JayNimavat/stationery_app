import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_1/src/screens/cart/bloc/cart/cart_bloc.dart';
import 'package:task_1/src/screens/cart/bloc/cart/cart_event.dart';
import 'package:task_1/src/screens/cart/cart.dart';
import 'package:task_1/src/screens/favorites/favorites.dart';
import 'package:task_1/src/screens/home/bloc/brands_bottomsheet/brands_bloc.dart';
import 'package:task_1/src/screens/home/bloc/brands_bottomsheet/brands_event.dart';
import 'package:task_1/src/screens/home/bloc/brands_bottomsheet/brands_state.dart';
import 'package:task_1/src/screens/home/bloc/brandswise_product/bloc_brandswise_product.dart';
import 'package:task_1/src/screens/home/bloc/brandswise_product/event_brandswise_product.dart';
import 'package:task_1/src/screens/home/bloc/brandswise_product/state_brandswise_product.dart';
import 'package:task_1/src/screens/home/bloc/home_count/bloc_home_count.dart';
import 'package:task_1/src/screens/home/bloc/home_count/event_home_count.dart';
import 'package:task_1/src/screens/home/bloc/home_count/state_home_count.dart';
import 'package:task_1/src/screens/home/products/product_detail/detail_screen.dart';

class BrandswiseProduct extends StatefulWidget {
  final String brandId;
  final List<String> selectedBrandIds;

  const BrandswiseProduct({
    super.key,
    required this.brandId,
    required this.selectedBrandIds,
  });

  @override
  State<BrandswiseProduct> createState() => _BrandswiseProductState();
}

class _BrandswiseProductState extends State<BrandswiseProduct> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCountBloc>(
          create: (context) => HomeCountBloc(),
        ),
        BlocProvider<BrandswiseProductBloc>(
          create: (context) => BrandswiseProductBloc(),
        ),
        BlocProvider<BrandsBloc>(
          create: (context) => BrandsBloc(),
        ),
        BlocProvider<CartBloc>(
          create: (context) => CartBloc(),
        ),
      ],
      child: Brands(
        brandId: widget.brandId,
        selectedBrandIds: widget.selectedBrandIds,
      ),
    );
  }
}

class Brands extends StatefulWidget {
  final String brandId;
  final List<String> selectedBrandIds;

  const Brands({
    super.key,
    required this.brandId,
    required this.selectedBrandIds,
  });

  @override
  State<Brands> createState() => _BrandsState();
}

class _BrandsState extends State<Brands> {
  List<String> selectedBrandIds = [];
  @override
  void initState() {
    super.initState();
    selectedBrandIds = widget.selectedBrandIds;
    BlocProvider.of<HomeCountBloc>(context).add(HomeCountBtnEvent());
    BlocProvider.of<BrandsBloc>(context).add(BrandsDataEvent());
    BlocProvider.of<BrandswiseProductBloc>(context)
        .add(BrandswiseProductDataEvent(brandId: widget.brandId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        elevation: 0,
        title: const Text('Brands'),
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
      body: BlocBuilder<BrandswiseProductBloc, BrandswiseProductState>(
        builder: (context, state) {
          if (state is BrandswiseProductLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is BrandswiseProductLoadedState) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  BlocBuilder<BrandsBloc, BrandsState>(
                    builder: (context, state) {
                      if (state is BrandsLoadingState) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is BrandsLoadedState) {
                        // print('BOTTOM SHEET BRAND ID');
                        // print(widget.selectedBrandIds);
                        return SizedBox(
                          height: MediaQuery.of(context).size.height / 17.5,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                            itemCount: state.brandsdata.brandsmodelData.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final brand =
                                  state.brandsdata.brandsmodelData[index];
                              final isSelected = selectedBrandIds
                                  .contains(brand.id.toString());
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    if (isSelected) {
                                      // print('REMOVE');
                                      selectedBrandIds
                                          .remove(brand.id.toString());
                                    } else if (!isSelected) {
                                      // print('ADDDDD');
                                      selectedBrandIds.add(brand.id.toString());
                                    }
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(5.0),
                                  margin: const EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color:
                                        isSelected ? Colors.blue : Colors.white,
                                    border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 1, 105, 190),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      state.brandsdata.brandsmodelData[index]
                                          .name,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: isSelected
                                            ? Colors.white
                                            : Colors.blue,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      } else if (state is BrandsErrorState) {
                        return Center(
                          child: Text(state.error),
                        );
                      }
                      return Container();
                    },
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  if (state.brandswiseProductData.brandswiseProductModelData
                      .isNotEmpty)
                    Expanded(
                      child: SingleChildScrollView(
                        child: GridView.builder(
                          itemCount: state.brandswiseProductData
                              .brandswiseProductModelData.length,
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
                            int runningIndex = 0;
                            // ignore: unused_local_variable
                            for (var brand in selectedBrandIds) {
                              final productsList = state.brandswiseProductData
                                  .brandswiseProductModelData;
                              if (index >= runningIndex &&
                                  index < runningIndex + productsList.length) {
                                final productData = state.brandswiseProductData
                                    .brandswiseProductModelData[index];
                                final hasDiscount = productData.discount != "0";
                                return InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ProductDetailScreen(
                                          productId: state
                                              .brandswiseProductData
                                              .brandswiseProductModelData[index]
                                              .id
                                              .toString(),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(5.0),
                                            topRight: Radius.circular(5.0),
                                          ),
                                          child: Image.network(
                                            state
                                                .brandswiseProductData
                                                .brandswiseProductModelData[
                                                    index]
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
                                                            .brandswiseProductData
                                                            .brandswiseProductModelData[
                                                                index]
                                                            .productName
                                                            .length >
                                                        25
                                                    ? '${state.brandswiseProductData.brandswiseProductModelData[index].productName.substring(0, 25)}...'
                                                    : state
                                                        .brandswiseProductData
                                                        .brandswiseProductModelData[
                                                            index]
                                                        .productName,
                                                maxLines: 1,
                                                style: const TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Text(
                                                state
                                                    .brandswiseProductData
                                                    .brandswiseProductModelData[
                                                        index]
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
                                                        .brandswiseProductData
                                                        .brandswiseProductModelData[
                                                            index]
                                                        .discount,
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.green),
                                                    children: const <TextSpan>[
                                                      TextSpan(
                                                        text: '% Off',
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color:
                                                                Colors.green),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              const SizedBox(height: 3),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons
                                                        .currency_rupee_outlined,
                                                    size: 16,
                                                    color: Colors.blue,
                                                  ),
                                                  Text(
                                                    hasDiscount
                                                        ? productData
                                                            .discountPrice
                                                        : productData.price,
                                                    style: TextStyle(
                                                        fontSize: hasDiscount
                                                            ? 16
                                                            : 15,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: hasDiscount
                                                            ? Colors.blue
                                                            : Colors.blue),
                                                  ),
                                                  const SizedBox(
                                                    width: 3,
                                                  ),
                                                  if (hasDiscount)
                                                    const Icon(
                                                      Icons
                                                          .currency_rupee_outlined,
                                                      size: 13,
                                                      color: Colors.red,
                                                    ),
                                                  if (hasDiscount)
                                                    Text(
                                                      state
                                                          .brandswiseProductData
                                                          .brandswiseProductModelData[
                                                              index]
                                                          .price,
                                                      style: const TextStyle(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.red,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                      ),
                                                    ),
                                                  const Spacer(),
                                                  InkWell(
                                                    onTap: () {
                                                      final isAddedCart = state
                                                              .brandswiseProductData
                                                              .brandswiseProductModelData[
                                                                  index]
                                                              .isCart ==
                                                          '1';
                                                      if (isAddedCart) {
                                                        BlocProvider.of<
                                                                    CartBloc>(
                                                                context)
                                                            .add(
                                                                RemoveCartEvent(
                                                          productId: state
                                                              .brandswiseProductData
                                                              .brandswiseProductModelData[
                                                                  index]
                                                              .id
                                                              .toString(),
                                                        ));
                                                        _showToast(
                                                            'Cart Item removed');
                                                      } else {
                                                        BlocProvider.of<
                                                                    CartBloc>(
                                                                context)
                                                            .add(AddToCartEvent(
                                                          productId: state
                                                              .brandswiseProductData
                                                              .brandswiseProductModelData[
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
                                                              .brandswiseProductData
                                                              .brandswiseProductModelData[
                                                                  index]
                                                              .isCart = '0';
                                                        } else {
                                                          state
                                                              .brandswiseProductData
                                                              .brandswiseProductModelData[
                                                                  index]
                                                              .isCart = '1';
                                                        }
                                                      });
                                                      BlocProvider.of<
                                                                  HomeCountBloc>(
                                                              context)
                                                          .add(
                                                              HomeCountBtnEvent());
                                                    },
                                                    child: Icon(
                                                      Icons.shopping_cart,
                                                      color: state
                                                                  .brandswiseProductData
                                                                  .brandswiseProductModelData[
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
                              }
                              runningIndex += state.brandswiseProductData
                                  .brandswiseProductModelData.length;
                            }
                            return Container(); // Return an empty widget if index doesn't match
                          },
                        ),
                      ),
                    )
                  else ...[
                    const SizedBox(
                      height: 320,
                    ),
                    const Center(
                      child: Text(
                        'Data Not Found...!',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ]
                ],
              ),
            );
          } else if (state is BrandswiseProductErrorState) {
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
