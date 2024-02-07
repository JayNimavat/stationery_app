import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_1/src/screens/cart/bloc/cart/cart_bloc.dart';
import 'package:task_1/src/screens/cart/bloc/cart/cart_event.dart';
import 'package:task_1/src/screens/favorites/bloc/save_wish/bloc_save_wish.dart';
import 'package:task_1/src/screens/favorites/bloc/save_wish/event_save_wish.dart';
import 'package:task_1/src/screens/favorites/favorites.dart';
import 'package:task_1/src/constants/colors.dart';
import 'package:task_1/src/screens/cart/cart.dart';
import 'package:task_1/src/screens/home/bloc/home_count/bloc_home_count.dart';
import 'package:task_1/src/screens/home/bloc/home_count/event_home_count.dart';
import 'package:task_1/src/screens/home/bloc/home_count/state_home_count.dart';
import 'package:task_1/src/screens/home/bloc/product_detail/bloc_product_detail.dart';
import 'package:task_1/src/screens/home/bloc/product_detail/event_product_detail.dart';
import 'package:task_1/src/screens/home/bloc/product_detail/state_product_detail.dart';
import 'package:task_1/src/screens/home/products/product_detail/image_viewer.dart';
import 'package:task_1/src/screens/home/products/products_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productId;

  const ProductDetailScreen({
    super.key,
    required this.productId,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCountBloc>(
          create: (context) => HomeCountBloc(),
        ),
        BlocProvider<ProductDetailBloc>(
          create: (context) => ProductDetailBloc(),
        ),
        BlocProvider<WishBloc>(
          create: (context) => WishBloc(),
        ),
        BlocProvider<CartBloc>(
          create: (context) => CartBloc(),
        ),
      ],
      child: DetailScreen(
        productId: widget.productId,
      ),
    );
  }
}

// ignore: must_be_immutable
class DetailScreen extends StatefulWidget {
  final String productId;

  DetailScreen({
    Key? key,
    required this.productId,
  }) : super(key: key);

  int counter = 1;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late PageController _pageController;
  int currentIndex = 0;
  static const _kDuration = Duration(milliseconds: 300);
  static const _kCurve = Curves.ease;

  bool descTextShowFlag = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeCountBloc>(context).add(HomeCountBtnEvent());
    BlocProvider.of<ProductDetailBloc>(context)
        .add(ProductDetailDataEvent(productId: widget.productId));
    _pageController = PageController();
  }

  void showImageViewer(String imageUrl) {
    showDialog(
      context: context,
      builder: (context) {
        return ImageViewer(
          imageUrl: imageUrl,
          productId: widget.productId,
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void nextFunction() {
    _pageController.nextPage(duration: _kDuration, curve: _kCurve);
  }

  void onChangedFunction(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        toolbarHeight: 50,
        elevation: 0,
        title: const Text('Details'),
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
      body: BlocBuilder<ProductDetailBloc, ProductDetailState>(
        builder: (context, state) {
          if (state is ProductDetailInitialState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProductDetailLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProductDetailLoadedState) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            // You can use this function to display the image viewer dialog
                            showImageViewer(state
                                .productDetailData
                                .productDetailModelData
                                .productData
                                .productImage);
                          },
                          child: SizedBox(
                            height: 340,
                            width: 370,
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                if (state
                                    .productDetailData
                                    .productDetailModelData
                                    .productData
                                    .productImages
                                    .isEmpty)
                                  Container(
                                    margin: const EdgeInsets.all(4.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5.0),
                                      child: Image.network(
                                        state
                                            .productDetailData
                                            .productDetailModelData
                                            .productData
                                            .productImage,
                                        height: 330,
                                        width: double.infinity,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  )
                                else
                                  PageView.builder(
                                    controller: _pageController,
                                    onPageChanged: onChangedFunction,
                                    dragStartBehavior: DragStartBehavior.start,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: state
                                        .productDetailData
                                        .productDetailModelData
                                        .productData
                                        .productImages
                                        .length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return GestureDetector(
                                        onTap: () {
                                          // You can use this function to display the image viewer dialog
                                          showImageViewer(state
                                              .productDetailData
                                              .productDetailModelData
                                              .productData
                                              .productImages[index]
                                              .productImage);
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.all(4.0),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            child: Image.network(
                                              state
                                                  .productDetailData
                                                  .productDetailModelData
                                                  .productData
                                                  .productImages[index]
                                                  .productImage,
                                              height: 330,
                                              width: double.infinity,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                Positioned(
                                  left: 160,
                                  bottom: 15,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(
                                      state
                                          .productDetailData
                                          .productDetailModelData
                                          .productData
                                          .productImages
                                          .length,
                                      (index) => Container(
                                        width: 10,
                                        height: 10,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 4),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: currentIndex == index
                                              ? Colors.blue
                                              : Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 17),
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(42.0),
                      ),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(18, 18, 1, 18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.productDetailData.productDetailModelData
                                    .productData.productName,
                                style: const TextStyle(
                                  fontSize: 17,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                state.productDetailData.productDetailModelData
                                    .productData.brandName,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black45,
                                ),
                              ),
                              const SizedBox(
                                height: 28,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.currency_rupee_outlined,
                                    size: 19,
                                    color: Colors.blue,
                                  ),
                                  Text(
                                    state.productDetailData.productDetailModelData
                                                .productData.discount ==
                                            "0"
                                        ? state
                                            .productDetailData
                                            .productDetailModelData
                                            .productData
                                            .price
                                        : state
                                            .productDetailData
                                            .productDetailModelData
                                            .productData
                                            .discountPrice,
                                    style: const TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.blue),
                                  ),
                                  if (state
                                          .productDetailData
                                          .productDetailModelData
                                          .productData
                                          .discount !=
                                      '0')
                                    const SizedBox(
                                      width: 3,
                                    ),
                                  if (state
                                          .productDetailData
                                          .productDetailModelData
                                          .productData
                                          .discount !=
                                      '0')
                                    const Icon(
                                      Icons.currency_rupee_outlined,
                                      size: 15,
                                      color: Colors.red,
                                    ),
                                  if (state
                                          .productDetailData
                                          .productDetailModelData
                                          .productData
                                          .discount !=
                                      '0')
                                    Text(
                                      state
                                          .productDetailData
                                          .productDetailModelData
                                          .productData
                                          .price,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.red,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                  if (state
                                          .productDetailData
                                          .productDetailModelData
                                          .productData
                                          .discount !=
                                      '0')
                                    const SizedBox(width: 3),
                                  if (state
                                          .productDetailData
                                          .productDetailModelData
                                          .productData
                                          .discount !=
                                      '0')
                                    RichText(
                                      text: TextSpan(
                                        text: state
                                            .productDetailData
                                            .productDetailModelData
                                            .productData
                                            .discount,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.green),
                                        children: const <TextSpan>[
                                          TextSpan(
                                            text: '% Off',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.green),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  const Text(
                                    'School :',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  const SizedBox(width: 3),
                                  Text(
                                    state
                                        .productDetailData
                                        .productDetailModelData
                                        .productData
                                        .schoolName,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.black45,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  const Text(
                                    'Board:',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  const SizedBox(width: 3),
                                  Text(
                                    state
                                        .productDetailData
                                        .productDetailModelData
                                        .productData
                                        .boardName,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.black45,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  const Text(
                                    'Medium:',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  const SizedBox(width: 3),
                                  Text(
                                    state
                                        .productDetailData
                                        .productDetailModelData
                                        .productData
                                        .mediumName,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.black45,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  const Text(
                                    'Standard:',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  const SizedBox(width: 3),
                                  Text(
                                    state
                                        .productDetailData
                                        .productDetailModelData
                                        .productData
                                        .standardName,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black45,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Container(
                                    width: 52,
                                    height: 49,
                                    decoration: BoxDecoration(
                                      color: state
                                                  .productDetailData
                                                  .productDetailModelData
                                                  .productData
                                                  .isFavorite ==
                                              '1'
                                          ? Colors.red[100]
                                          : Colors.transparent,
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(15),
                                        topLeft: Radius.circular(15),
                                      ),
                                    ),
                                    child: IconButton(
                                      icon: Icon(
                                        state
                                                    .productDetailData
                                                    .productDetailModelData
                                                    .productData
                                                    .isFavorite ==
                                                '1'
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: state
                                                    .productDetailData
                                                    .productDetailModelData
                                                    .productData
                                                    .isFavorite ==
                                                '1'
                                            ? Colors.red
                                            : Colors.red,
                                        size: 29,
                                      ),
                                      tooltip: 'Favorite Icon',
                                      onPressed: () {
                                        if (state
                                                .productDetailData
                                                .productDetailModelData
                                                .productData
                                                .isFavorite ==
                                            '1') {
                                          BlocProvider.of<WishBloc>(context)
                                              .add(RemoveWishEvent(
                                            wishlistId: state
                                                .productDetailData
                                                .productDetailModelData
                                                .productData
                                                .wishlistId
                                                .toString(),
                                          ));
                                          _showToast(
                                              'Item removed Successfully');
                                        } else {
                                          // Trigger add event
                                          BlocProvider.of<WishBloc>(context)
                                              .add(SaveWishDataEvent(
                                            productId: state
                                                .productDetailData
                                                .productDetailModelData
                                                .productData
                                                .id
                                                .toString(),
                                          ));
                                          _showToast(
                                              'Save Wishlist Successfully...!');
                                        }
                                        setState(() {
                                          if (state
                                                  .productDetailData
                                                  .productDetailModelData
                                                  .productData
                                                  .isFavorite ==
                                              '1') {
                                            state
                                                .productDetailData
                                                .productDetailModelData
                                                .productData
                                                .isFavorite = '0';
                                          } else {
                                            state
                                                .productDetailData
                                                .productDetailModelData
                                                .productData
                                                .isFavorite = '1';
                                          }
                                        });
                                        BlocProvider.of<HomeCountBloc>(context)
                                            .add(HomeCountBtnEvent());
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                descTextShowFlag
                                    ? state
                                        .productDetailData
                                        .productDetailModelData
                                        .productData
                                        .description
                                    : '${state.productDetailData.productDetailModelData.productData.description.substring(0, 24)}...',
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.start,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    descTextShowFlag = !descTextShowFlag;
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    descTextShowFlag
                                        ? const Text(
                                            "< See Less Details",
                                            style:
                                                TextStyle(color: Colors.blue),
                                          )
                                        : const Text(
                                            "See More Details >",
                                            style:
                                                TextStyle(color: Colors.blue),
                                          ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(35),
                                  color: bgColor,
                                ),
                                height: 80,
                                width: 170,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        shape: const CircleBorder(),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          widget.counter == 1
                                              // ignore: avoid_print
                                              ? print('counter at 1')
                                              : widget.counter--;
                                        });
                                      },
                                      child: const Icon(
                                        Icons.remove,
                                        color: Colors.black,
                                        size: 30,
                                      ),
                                    ),
                                    Text(
                                      '${widget.counter}',
                                      style: const TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        shape: const CircleBorder(),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          widget.counter++;
                                        });
                                      },
                                      child: const Icon(
                                        Icons.add,
                                        color: Colors.black,
                                        size: 30,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        "Similar Products",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const ProductsWidget(),
                            ),
                          );
                        },
                        child: const Row(
                          children: [
                            Text(
                              'View All',
                              style: TextStyle(
                                color: Colors.black87,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.black87,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(42.0),
                      ),
                      color: Colors.white70,
                    ),
                    margin: EdgeInsets.only(bottom: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          GridView.builder(
                            itemCount: state
                                .productDetailData
                                .productDetailModelData
                                .topSellingProductList
                                .length,
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
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductDetailScreen(
                                        productId: state
                                            .productDetailData
                                            .productDetailModelData
                                            .topSellingProductList[index]
                                            .id
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
                                              .productDetailData
                                              .productDetailModelData
                                              .topSellingProductList[index]
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
                                                      .productDetailData
                                                      .productDetailModelData
                                                      .topSellingProductList[
                                                          index]
                                                      .productName,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: const TextStyle(
                                                fontSize: 13,
                                                //  fontWeight: FontWeight.w600,
                                                color: Colors.black,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              state
                                                  .productDetailData
                                                  .productDetailModelData
                                                  .topSellingProductList[index]
                                                  .brandName,
                                              style: const TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black45,
                                              ),
                                            ),
                                            const SizedBox(height: 12),
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.currency_rupee_outlined,
                                                  size: 15,
                                                  color: Colors.blue,
                                                ),
                                                Text(
                                                  state
                                                      .productDetailData
                                                      .productDetailModelData
                                                      .topSellingProductList[
                                                          index]
                                                      .price,
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.blue,
                                                  ),
                                                ),
                                                const Spacer(),
                                                InkWell(
                                                  onTap: () {
                                                    final isAddedCart = state
                                                            .productDetailData
                                                            .productDetailModelData
                                                            .topSellingProductList[
                                                                index]
                                                            .isCart ==
                                                        "1";

                                                    if (isAddedCart) {
                                                      BlocProvider.of<CartBloc>(
                                                              context)
                                                          .add(RemoveCartEvent(
                                                        productId: state
                                                            .productDetailData
                                                            .productDetailModelData
                                                            .topSellingProductList[
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
                                                            .productDetailData
                                                            .productDetailModelData
                                                            .topSellingProductList[
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
                                                            .productDetailData
                                                            .productDetailModelData
                                                            .topSellingProductList[
                                                                index]
                                                            .isCart = "0";
                                                      } else {
                                                        state
                                                            .productDetailData
                                                            .productDetailModelData
                                                            .topSellingProductList[
                                                                index]
                                                            .isCart = "1";
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
                                                                .productDetailData
                                                                .productDetailModelData
                                                                .topSellingProductList[
                                                                    index]
                                                                .isCart ==
                                                            "1"
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
                  ),
                ],
              ),
            );
          } else if (state is ProductDetailErrorState) {
            return Center(
              child: Text(state.error),
            );
          }
          return Container();
        },
      ),
      bottomNavigationBar: BlocBuilder<ProductDetailBloc, ProductDetailState>(
        builder: (BuildContext contexts, bottomstate) {
          if (bottomstate is ProductDetailLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (bottomstate is ProductDetailLoadedState) {
            return Row(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 16,
                  width: MediaQuery.of(context).size.width * 0.5,
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {
                      if (bottomstate.productDetailData.productDetailModelData
                              .productData.isCart ==
                          "0") {
                        BlocProvider.of<CartBloc>(context).add(AddToCartEvent(
                          productId: bottomstate.productDetailData
                              .productDetailModelData.productData.id
                              .toString(),
                          qty: widget.counter.toString(),
                        ));
                        // print(widget.counter);
                        _showToast('Product added Successfully');
                      } else {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const CartScreen(),
                          ),
                        );
                      }
                      BlocProvider.of<HomeCountBloc>(context)
                          .add(HomeCountBtnEvent());
                    },
                    child: Center(
                      child: Text(bottomstate.productDetailData
                                  .productDetailModelData.productData.isCart ==
                              "0"
                          ? 'Add to Cart'
                          : 'Go to Cart'),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 16,
                  width: MediaQuery.of(context).size.width * 0.5,
                  color: Colors.blue,
                  child: InkWell(
                    onTap: () {
                      if (bottomstate.productDetailData.productDetailModelData
                              .productData.isCart ==
                          "0") {
                        Navigator.of(context).pop();
                        BlocProvider.of<CartBloc>(context).add(AddToCartEvent(
                          productId: bottomstate.productDetailData
                              .productDetailModelData.productData.id
                              .toString(),
                          qty: widget.counter.toString(),
                        ));
                        // print(widget.counter);
                        _showToast('Product added Successfully');
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const CartScreen(),
                          ),
                        );
                      } else {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const CartScreen(),
                          ),
                        );
                      }
                      BlocProvider.of<HomeCountBloc>(context)
                          .add(HomeCountBtnEvent());
                    },
                    child: const Center(
                      child: Text(
                        'Buy Now',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else if (bottomstate is ProductDetailErrorState) {
            return Center(
              child: Text(bottomstate.error),
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
