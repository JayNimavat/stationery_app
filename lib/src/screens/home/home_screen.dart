import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_1/src/screens/cart/bloc/cart/cart_bloc.dart';
import 'package:task_1/src/screens/cart/bloc/cart/cart_event.dart';
import 'package:task_1/src/screens/home/bloc/home_count/bloc_home_count.dart';
import 'package:task_1/src/screens/home/bloc/home_count/event_home_count.dart';
import 'package:task_1/src/screens/home/bloc/home_count/state_home_count.dart';
import 'package:task_1/src/screens/home/bloc/search/search_bloc.dart';
import 'package:task_1/src/screens/home/bloc/second_bannerlist/bloc_second_bannerlist.dart';
import 'package:task_1/src/screens/home/bloc/second_bannerlist/event_second_bannerlist.dart';
import 'package:task_1/src/screens/home/bloc/second_bannerlist/state_second_bannerlist.dart';
import 'package:task_1/src/screens/home/brands/brands_bottomsheet.dart';
import 'package:task_1/src/screens/home/features/features.dart';
import 'package:task_1/src/screens/home/bloc/allproduct/allproduct_bloc.dart';
import 'package:task_1/src/screens/home/bloc/allproduct/allproduct_event.dart';
import 'package:task_1/src/screens/home/bloc/allproduct/allproduct_state.dart';
import 'package:task_1/src/screens/home/bloc/bannerlist/banner_bloc.dart';
import 'package:task_1/src/screens/home/bloc/bannerlist/banner_event.dart';
import 'package:task_1/src/screens/home/bloc/bannerlist/banner_state.dart';
import 'package:task_1/src/screens/home/flash_deal/flash_deal.dart';
import 'package:task_1/src/screens/home/products/products_screen.dart';
import 'package:task_1/src/constants/colors.dart';
import 'package:task_1/src/screens/cart/cart.dart';
import 'package:task_1/src/screens/home/products/product_detail/detail_screen.dart';
import 'package:task_1/src/screens/favorites/favorites.dart';
import 'package:task_1/src/screens/home/search/search_screen.dart';
import 'package:task_1/src/screens/home/select_school/school_bottomsheet.dart';
import 'package:task_1/src/screens/home/today_deal/today_deal.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<HomeCountBloc>(
        create: (context) => HomeCountBloc(),
      ),
      BlocProvider<SearchBloc>(
        create: (BuildContext context) => SearchBloc(),
      ),
      BlocProvider<BannerBloc>(
        create: (BuildContext context) => BannerBloc(),
      ),
      BlocProvider<AllproductBloc>(
        create: (BuildContext context) => AllproductBloc(),
      ),
      BlocProvider<SecondBannerListBloc>(
        create: (BuildContext context) => SecondBannerListBloc(),
      ),
      BlocProvider<CartBloc>(
        create: (context) => CartBloc(),
      ),
    ], child: const HomeScreen());
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController search = TextEditingController();
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  Timer? _timer;
  bool isBannerDataLoaded = false;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeCountBloc>(context).add(HomeCountBtnEvent());
    BlocProvider.of<BannerBloc>(context).add(FetchBannerEvent());
    BlocProvider.of<BannerBloc>(context).stream.listen((state) {
      if (state is BannerLoadedState) {
        setState(() {
          isBannerDataLoaded = true;
        });
      }
    });
    BlocProvider.of<AllproductBloc>(context)
        .add(AllproductdataEvent(filterPrice: '', filterSortBy: ''));
    BlocProvider.of<SecondBannerListBloc>(context)
        .add(SecondBannerListDataEvent());
    streamController = StreamController<CombinedBloc>();
    streamController.add(CombinedBloc(
        bannerBloc: BlocProvider.of<BannerBloc>(context),
        secondBannerListBloc: BlocProvider.of<SecondBannerListBloc>(context)));
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    streamController.close();
    _timer?.cancel();
  }

  final List<Map<String, dynamic>> catList = [
    {
      'name': 'Select School',
      'icon': Icons.school_outlined,
      'openType': 'bottom_sheet_school',
    },
    {
      'name': 'Product',
      'icon': Icons.shopping_bag_outlined,
      'openType': 'products_page',
    },
    {
      'name': 'Brands',
      'icon': Icons.branding_watermark_outlined,
      'openType': 'bottom_sheet_brands',
    },
    {
      'name': 'Features',
      'icon': Icons.star_border_outlined,
      'openType': 'features_page',
    },
  ];

  StreamController<CombinedBloc> streamController =
      StreamController<CombinedBloc>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        toolbarHeight: 50,
        elevation: 0,
        title: const Text('Home'),
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
      body: StreamBuilder<CombinedBloc>(
        stream: streamController.stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            if (isBannerDataLoaded) {
              final bannerState = snapshot.data!.bannerState;
              final secondBannerListState =
                  snapshot.data!.secondBannerListState;
              if (bannerState is BannerLoadedState) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: SizedBox(
                          height: 50,
                          width: 400,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            color: Colors.white,
                            elevation: 4,
                            child: Container(
                              padding: const EdgeInsets.only(left: 12),
                              child: TextFormField(
                                autofocus: false,
                                controller: search,
                                textInputAction: TextInputAction.search,
                                decoration: const InputDecoration(
                                  hintText: "Search anything.....",
                                  border: InputBorder.none,
                                  fillColor: Colors.white,
                                  suffixIcon: Icon(
                                    Icons.search_outlined,
                                  ),
                                  suffixIconColor: Colors.black45,
                                ),
                                onFieldSubmitted: (value) {
                                  FocusScope.of(context).unfocus();
                                  Navigator.push(
                                    context,
                                    ScaleTransition1(
                                      SearchScreen(
                                        keyword: value,
                                      ),
                                    ),
                                  );
                                  search.clear();
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        height: 200,
                        width: 380,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            PageView.builder(
                              itemCount:
                                  bannerState.bannerData.bannerlistData.length,
                              controller: _pageController,
                              itemBuilder: (BuildContext context, index) {
                                return Container(
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.network(
                                      bannerState.bannerData
                                          .bannerlistData[index].image,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                );
                              },
                            ),
                            Positioned(
                              left: 165,
                              bottom: 15,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  bannerState.bannerData.bannerlistData.length,
                                  (index) => Container(
                                    width: 10,
                                    height: 10,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: _currentPage == index
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () async {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const TodayDealScreen(),
                                ),
                              );
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width - 207,
                              height: 90,
                              margin: const EdgeInsets.all(5),
                              padding: const EdgeInsets.only(left: 8),
                              child: Card(
                                color: Colors.white,
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/img/today.png',
                                      height: 50,
                                      width: 40,
                                    ),
                                    const Text(
                                      'Today Deal',
                                      style: TextStyle(
                                        color: Colors.black45,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const FlashDealScreen(),
                                ),
                              );
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width - 207,
                              height: 90,
                              margin: const EdgeInsets.all(5),
                              padding: const EdgeInsets.only(right: 8),
                              child: Card(
                                color: Colors.white,
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/img/flash.png',
                                      height: 50,
                                      width: 40,
                                    ),
                                    const Text(
                                      'Flash Deal',
                                      style: TextStyle(
                                        color: Colors.black45,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      if (secondBannerListState is SecondBannerListLoadedState)
                        ListView.builder(
                          itemCount: secondBannerListState.secondBannerListData
                              .secondBannerListModelData.length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {},
                              child: Container(
                                width: MediaQuery.of(context).size.width - 30,
                                height: 150,
                                margin: const EdgeInsets.all(5),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.network(
                                    secondBannerListState.secondBannerListData
                                        .secondBannerListModelData[index].image,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      else
                        const Center(child: Text('ERROR IN SECOND BANNER')),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            const Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 10,
                                  ),
                                  child: Text(
                                    "Featured Categories",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            GridView.builder(
                              padding: const EdgeInsets.all(2),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 0.3,
                                mainAxisSpacing: 3.0,
                                childAspectRatio:
                                    (MediaQuery.of(context).size.height * 1) /
                                        (1.5 * 185),
                              ),
                              shrinkWrap: true,
                              itemCount: catList.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () async {
                                    String? openType =
                                        catList[index]['openType'];
                                    if (openType == 'products_page') {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const ProductsWidget(),
                                        ),
                                      );
                                    } else if (openType == 'features_page') {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const Features(),
                                        ),
                                      );
                                    } else if (openType ==
                                        'bottom_sheet_brands') {
                                      showModalBottomSheet(
                                        context: context,
                                        showDragHandle: true,
                                        isScrollControlled: true,
                                        //  barrierColor: Colors.transparent,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(15.0)),
                                        ),
                                        builder: (context) =>
                                            const BrandsBottomSheet(),
                                      );
                                    } else if (openType ==
                                        'bottom_sheet_school') {
                                      showModalBottomSheet(
                                        context: context,
                                        showDragHandle: true,
                                        isScrollControlled: true,
                                        //  barrierColor: Colors.transparent,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(15.0)),
                                        ),
                                        builder: (context) =>
                                            const SchoolBottomSheet(),
                                      );
                                    }
                                  },
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width - 210,
                                    height: 50,
                                    margin: const EdgeInsets.only(left: 8),
                                    child: Card(
                                      color: Colors.white,
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Icon(
                                            catList[index]['icon'],
                                            color: Colors.blue,
                                            size: 29,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            catList[index]['name'],
                                            style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.black45,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 10,
                                  ),
                                  child: Text(
                                    "All Products",
                                    style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            BlocBuilder<AllproductBloc, AllproductState>(
                                builder: (context, state) {
                              if (state is AllproductLoadingState) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (state is AllproductLoadedState) {
                                return GridView.builder(
                                  itemCount:
                                      state.productData.allproductData.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 14.0,
                                    crossAxisSpacing: 10.0,
                                    mainAxisExtent: 247,
                                  ),
                                  itemBuilder: (BuildContext context, index) {
                                    final productData =
                                        state.productData.allproductData[index];

                                    // Check if the product has a discount
                                    final hasDiscount =
                                        productData.discount != "0";

                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ProductDetailScreen(
                                              productId: state.productData
                                                  .allproductData[index].id
                                                  .toString(),
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height,
                                        margin: const EdgeInsets.only(
                                            left: 4.0, right: 4.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
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
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(5.0),
                                                topRight: Radius.circular(5.0),
                                              ),
                                              child: Image.network(
                                                state
                                                    .productData
                                                    .allproductData[index]
                                                    .productImage,
                                                height: 155,
                                                width: double.infinity,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    state
                                                                .productData
                                                                .allproductData[
                                                                    index]
                                                                .productName
                                                                .length >
                                                            25
                                                        ? '${state.productData.allproductData[index].productName.substring(0, 25)}...'
                                                        : state
                                                            .productData
                                                            .allproductData[
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
                                                        .productData
                                                        .allproductData[index]
                                                        .brandName,
                                                    style: const TextStyle(
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black45,
                                                    ),
                                                  ),
                                                  if (hasDiscount)
                                                    RichText(
                                                      text: TextSpan(
                                                        text: state
                                                            .productData
                                                            .allproductData[
                                                                index]
                                                            .discount,
                                                        style: const TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color:
                                                                Colors.green),
                                                        children: const <TextSpan>[
                                                          TextSpan(
                                                            text: '% Off',
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Colors
                                                                    .green),
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
                                                              : Colors.blue,
                                                        ),
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
                                                              .productData
                                                              .allproductData[
                                                                  index]
                                                              .price,
                                                          style:
                                                              const TextStyle(
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
                                                                  .productData
                                                                  .allproductData[
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
                                                                  .productData
                                                                  .allproductData[
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
                                                                .add(
                                                                    AddToCartEvent(
                                                              productId: state
                                                                  .productData
                                                                  .allproductData[
                                                                      index]
                                                                  .id
                                                                  .toString(),
                                                              qty: '1',
                                                            ));
                                                            _showToast(
                                                                'Product added Successfully');
                                                          }

                                                          BlocProvider.of<
                                                                      HomeCountBloc>(
                                                                  context)
                                                              .add(
                                                                  HomeCountBtnEvent());

                                                          setState(() {
                                                            if (isAddedCart) {
                                                              state
                                                                  .productData
                                                                  .allproductData[
                                                                      index]
                                                                  .isCart = '0';
                                                            } else {
                                                              state
                                                                  .productData
                                                                  .allproductData[
                                                                      index]
                                                                  .isCart = '1';
                                                            }
                                                          });
                                                        },
                                                        child: Icon(
                                                          Icons.shopping_cart,
                                                          color: state
                                                                      .productData
                                                                      .allproductData[
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
                                );
                              } else if (state is AllproductErrorState) {
                                return Center(
                                  child: Text(state.error),
                                );
                              }
                              return Container();
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }

              return Container();
            } else {
              return const Center(child: CircularProgressIndicator());
            }
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

class ScaleTransition1 extends PageRouteBuilder {
  final Widget page;

  ScaleTransition1(this.page)
      : super(
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: const Duration(milliseconds: 1000),
          reverseTransitionDuration: const Duration(milliseconds: 200),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
                curve: Curves.fastLinearToSlowEaseIn,
                parent: animation,
                reverseCurve: Curves.fastOutSlowIn);
            return ScaleTransition(
              alignment: Alignment.bottomCenter,
              scale: animation,
              child: child,
            );
          },
        );
}

class CombinedBloc {
  final BannerBloc bannerBloc;
  final SecondBannerListBloc secondBannerListBloc;

  CombinedBloc({required this.bannerBloc, required this.secondBannerListBloc});

  // Define getters for bannerState and secondBannerListState
  BannerState get bannerState => bannerBloc.state;
  SecondBannerListState get secondBannerListState => secondBannerListBloc.state;

  Stream<CombinedState> get combinedStream {
    return CombineLatestStream.combine2<BannerState, SecondBannerListState,
        CombinedState>(
      bannerBloc.stream,
      secondBannerListBloc.stream,
      (bannerState, secondBannerListState) {
        return CombinedState(bannerState, secondBannerListState);
      },
    );
  }
}

final CombinedBloc combinedBloc = CombinedBloc(
  bannerBloc: BannerBloc(),
  secondBannerListBloc: SecondBannerListBloc(),
);

class CombinedState {
  final BannerState bannerState;
  final SecondBannerListState secondBannerListState;

  CombinedState(this.bannerState, this.secondBannerListState);
}
