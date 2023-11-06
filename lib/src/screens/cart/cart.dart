import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_1/src/constants/colors.dart';
import 'package:task_1/src/screens/cart/bloc/apply_coupon/bloc_applycoupon.dart';
import 'package:task_1/src/screens/cart/bloc/apply_coupon/event_applycoupon.dart';
import 'package:task_1/src/screens/cart/bloc/cart/cart_bloc.dart';
import 'package:task_1/src/screens/cart/bloc/cart/cart_event.dart';
import 'package:task_1/src/screens/cart/bloc/cart_list/bloc_cart_list.dart';
import 'package:task_1/src/screens/cart/bloc/cart_list/event_cart_list.dart';
import 'package:task_1/src/screens/cart/bloc/cart_list/state_cart_list.dart';
import 'package:task_1/src/screens/cart/bottomsheet.dart';
import 'package:task_1/src/screens/favorites/bloc/wish_list/bloc_wish_list.dart';
import 'package:task_1/src/screens/home/products/products_screen.dart';
import 'package:task_1/src/screens/cart/checkout/checkout.dart';

class CheckoutData {
  final double totalMRP;
  final double discountOnMRP;
  final double couponDiscount;
  final double orderTotal;

  CheckoutData({
    required this.totalMRP,
    required this.discountOnMRP,
    required this.couponDiscount,
    required this.orderTotal,
  });
}

class CartScreen extends StatefulWidget {
  const CartScreen({
    super.key,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CartListBloc>(
          create: (context) => CartListBloc(),
        ),
        BlocProvider<CartBloc>(
          create: (context) => CartBloc(),
        ),
        BlocProvider<WishListBloc>(
          create: (BuildContext context) => WishListBloc(),
        ),
        BlocProvider(
          create: (context) => ApplyCouponBloc(),
        ),
      ],
      child: const CartListScreen(),
    );
  }
}

class CartListScreen extends StatefulWidget {
  const CartListScreen({
    super.key,
  });

  @override
  State<CartListScreen> createState() => _CartListScreenState();
}

class _CartListScreenState extends State<CartListScreen> {
  final TextEditingController couponController = TextEditingController();
  bool isCouponApplied = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CartListBloc>(context).add(CartListDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        toolbarHeight: 50,
        elevation: 0,
        title: const Text('Cart'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orangeAccent, Colors.redAccent],
            ),
          ),
        ),
      ),
      body: BlocBuilder<CartListBloc, CartListState>(
        builder: (context, state) {
          if (state is CartListLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CartListLoadedState) {
            num orderTotal =
                state.cartListData.cartListModelData.cartSummary.subTotal -
                    (state.cartListData.cartListModelData.cartSummary.subTotal *
                        15 /
                        100);
            num couponDiscount =
                state.cartListData.cartListModelData.cartSummary.subTotal -
                    orderTotal;
            num finalTotal = orderTotal -
                state.cartListData.cartListModelData.cartSummary.discountTotal;
            if (state.cartListData.cartListModelData.cartDetail.isNotEmpty) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListView.builder(
                        itemCount: state
                            .cartListData.cartListModelData.cartDetail.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Dismissible(
                            key: Key(state.cartListData.cartListModelData
                                .cartDetail[index].productData.productName
                                .toString()),
                            resizeDuration: const Duration(milliseconds: 200),
                            dismissThresholds: const <DismissDirection,
                                double>{},
                            movementDuration: const Duration(milliseconds: 200),
                            crossAxisEndOffset: 0.0,
                            direction: DismissDirection.startToEnd,
                            confirmDismiss: (DismissDirection direction) async {
                              return await showModalBottomSheet(
                                context: context,
                                //  barrierColor: Colors.transparent,
                                builder: (context2) {
                                  return CartBottomSheet(
                                    productId: state
                                        .cartListData
                                        .cartListModelData
                                        .cartDetail[index]
                                        .productId
                                        .toString(),
                                    productImage: state
                                        .cartListData
                                        .cartListModelData
                                        .cartDetail[index]
                                        .productData
                                        .productImage,
                                    productName: state
                                        .cartListData
                                        .cartListModelData
                                        .cartDetail[index]
                                        .productData
                                        .productName,
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child:
                                  const Icon(Icons.delete, color: Colors.white),
                            ),
                            onDismissed: (direction) {
                              //  deleteItem(index);
                              BlocProvider.of<CartBloc>(context)
                                  .add(RemoveCartEvent(
                                productId: state.cartListData.cartListModelData
                                    .cartDetail[index].productId
                                    .toString(),
                              ));
                              BlocProvider.of<CartListBloc>(context)
                                  .add(CartListDataEvent());
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
                                      onTap: () {},
                                      child: Image.network(
                                        state
                                            .cartListData
                                            .cartListModelData
                                            .cartDetail[index]
                                            .productData
                                            .productImage,
                                        height: 130,
                                        width: 95,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 9,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          state
                                                      .cartListData
                                                      .cartListModelData
                                                      .cartDetail[index]
                                                      .productData
                                                      .productName
                                                      .length >
                                                  25
                                              ? '${state.cartListData.cartListModelData.cartDetail[index].productData.productName.substring(0, 25)}...'
                                              : state
                                                  .cartListData
                                                  .cartListModelData
                                                  .cartDetail[index]
                                                  .productData
                                                  .productName,
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          state
                                              .cartListData
                                              .cartListModelData
                                              .cartDetail[index]
                                              .productData
                                              .brandName,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.black45,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
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
                                                          .cartListData
                                                          .cartListModelData
                                                          .cartDetail[index]
                                                          .productData
                                                          .discount ==
                                                      "0"
                                                  ? state
                                                      .cartListData
                                                      .cartListModelData
                                                      .cartDetail[index]
                                                      .productData
                                                      .price
                                                  : state
                                                      .cartListData
                                                      .cartListModelData
                                                      .cartDetail[index]
                                                      .productData
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
                                                    .cartListData
                                                    .cartListModelData
                                                    .cartDetail[index]
                                                    .productData
                                                    .discount !=
                                                "0")
                                              const Icon(
                                                Icons.currency_rupee_outlined,
                                                size: 13,
                                                color: Colors.red,
                                              ),
                                            if (state
                                                    .cartListData
                                                    .cartListModelData
                                                    .cartDetail[index]
                                                    .productData
                                                    .discount !=
                                                "0")
                                              Text(
                                                state
                                                    .cartListData
                                                    .cartListModelData
                                                    .cartDetail[index]
                                                    .productData
                                                    .price,
                                                style: const TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.red,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                ),
                                              ),
                                            const SizedBox(width: 3),
                                            if (state
                                                    .cartListData
                                                    .cartListModelData
                                                    .cartDetail[index]
                                                    .productData
                                                    .discount !=
                                                "0")
                                              RichText(
                                                text: TextSpan(
                                                  text: state
                                                      .cartListData
                                                      .cartListModelData
                                                      .cartDetail[index]
                                                      .productData
                                                      .discount,
                                                  style: const TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.green),
                                                  children: const <TextSpan>[
                                                    TextSpan(
                                                      text: '% Off',
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.green),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          height: 35,
                                          width: 80,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Colors.blue,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  if (state
                                                          .cartListData
                                                          .cartListModelData
                                                          .cartDetail[index]
                                                          .qty ==
                                                      '1') {
                                                    showModalBottomSheet(
                                                      context: context,
                                                      //  barrierColor: Colors.transparent,
                                                      builder: (context2) {
                                                        return CartBottomSheet(
                                                          productId: state
                                                              .cartListData
                                                              .cartListModelData
                                                              .cartDetail[index]
                                                              .productId
                                                              .toString(),
                                                          productImage: state
                                                              .cartListData
                                                              .cartListModelData
                                                              .cartDetail[index]
                                                              .productData
                                                              .productImage,
                                                          productName: state
                                                              .cartListData
                                                              .cartListModelData
                                                              .cartDetail[index]
                                                              .productData
                                                              .productName,
                                                        );
                                                      },
                                                    );
                                                  } else {
                                                    int currentQty = int.parse(
                                                        state
                                                            .cartListData
                                                            .cartListModelData
                                                            .cartDetail[index]
                                                            .qty);
                                                    currentQty--;
                                                    BlocProvider.of<CartBloc>(
                                                            context)
                                                        .add(AddToCartEvent(
                                                      productId: state
                                                          .cartListData
                                                          .cartListModelData
                                                          .cartDetail[index]
                                                          .productId,
                                                      qty:
                                                          currentQty.toString(),
                                                    ));
                                                    BlocProvider.of<
                                                                CartListBloc>(
                                                            context)
                                                        .add(
                                                            CartListDataEvent());
                                                    // print(currentQty);
                                                  }
                                                },
                                                child: Icon(
                                                  state
                                                              .cartListData
                                                              .cartListModelData
                                                              .cartDetail[index]
                                                              .qty ==
                                                          '1'
                                                      ? Icons.delete_outline
                                                      : Icons.remove,
                                                  color: Colors.white,
                                                  size: 25,
                                                ),
                                              ),
                                              Container(
                                                width: 18,
                                                height: 28,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  color: Colors.white,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    state
                                                        .cartListData
                                                        .cartListModelData
                                                        .cartDetail[index]
                                                        .qty, // Display the initial value
                                                    style: const TextStyle(
                                                      fontSize: 17,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  int currentQty = int.parse(
                                                      state
                                                          .cartListData
                                                          .cartListModelData
                                                          .cartDetail[index]
                                                          .qty);
                                                  currentQty++;
                                                  BlocProvider.of<CartBloc>(
                                                          context)
                                                      .add(AddToCartEvent(
                                                    productId: state
                                                        .cartListData
                                                        .cartListModelData
                                                        .cartDetail[index]
                                                        .productId,
                                                    qty: currentQty.toString(),
                                                  ));
                                                  BlocProvider.of<CartListBloc>(
                                                          context)
                                                      .add(CartListDataEvent());
                                                  // print(currentQty);
                                                },
                                                child: const Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                  size: 25,
                                                ),
                                              ),
                                            ],
                                          ),
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
                                              return CartBottomSheet(
                                                productId: state
                                                    .cartListData
                                                    .cartListModelData
                                                    .cartDetail[index]
                                                    .productId
                                                    .toString(),
                                                productImage: state
                                                    .cartListData
                                                    .cartListModelData
                                                    .cartDetail[index]
                                                    .productData
                                                    .productImage,
                                                productName: state
                                                    .cartListData
                                                    .cartListModelData
                                                    .cartDetail[index]
                                                    .productData
                                                    .productName,
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
                      const SizedBox(
                        height: 13,
                      ),
                      const Text(
                        'Coupans and Discounts',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 1,
                        height: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 14, top: 5.0, right: 14, bottom: 5.0),
                          child: Form(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 50,
                                      width: 235,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        color: bgColor,
                                        child: Container(
                                          padding:
                                              const EdgeInsets.only(left: 12),
                                          child: TextFormField(
                                            autofocus: false,
                                            controller: couponController,
                                            decoration: const InputDecoration(
                                              hintText:
                                                  "Apply the coupon code...",
                                              border: InputBorder.none,
                                              fillColor: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        String enteredCouponCode =
                                            couponController.text;
                                        BlocProvider.of<ApplyCouponBloc>(
                                                context)
                                            .add(ApplyCouponBtnEvent(
                                                couponCode: enteredCouponCode));
                                        if (enteredCouponCode.isNotEmpty) {
                                          if (enteredCouponCode == 'HRKS20') {
                                            // Coupon code is valid
                                            setState(() {
                                              isCouponApplied =
                                                  !isCouponApplied;
                                            });
                                          } else {
                                            _showToast('Invalid Coupon Code');
                                          }
                                        }
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                302,
                                        height: 57,
                                        margin: const EdgeInsets.all(5),
                                        child: Card(
                                          color: isCouponApplied
                                              ? Colors.red
                                              : Colors.blue,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Center(
                                            child: Text(
                                              isCouponApplied
                                                  ? 'Remove'
                                                  : 'Apply',
                                              style: const TextStyle(
                                                fontSize: 19,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Payment Summary',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width - 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        'Total MRP',
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                      const Spacer(),
                                      const Icon(
                                        Icons.currency_rupee,
                                        size: 15,
                                      ),
                                      Text(
                                        state.cartListData.cartListModelData
                                            .cartSummary.subTotal
                                            .toString(),
                                        style: const TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Divider(thickness: 0.8),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        'Discount on MRP',
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                      const Spacer(),
                                      const Text(
                                        '-',
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 15,
                                        ),
                                      ),
                                      const Icon(
                                        Icons.currency_rupee,
                                        size: 15,
                                        color: Colors.green,
                                      ),
                                      Text(
                                        state.cartListData.cartListModelData
                                            .cartSummary.discountTotal
                                            .toString(),
                                        style: const TextStyle(
                                          color: Colors.green,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Divider(thickness: 0.8),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      const Text('Coupon Discount'),
                                      const Spacer(),
                                      const Text(
                                        '-',
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 15,
                                        ),
                                      ),
                                      const Icon(
                                        Icons.currency_rupee,
                                        size: 15,
                                        color: Colors.green,
                                      ),
                                      Text(
                                        isCouponApplied
                                            ? couponDiscount.round().toString()
                                            : state
                                                .cartListData
                                                .cartListModelData
                                                .cartSummary
                                                .couponDiscount
                                                .toString(),
                                        style: const TextStyle(
                                          color: Colors.green,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Divider(thickness: 0.8),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        'Order Total',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Spacer(),
                                      const Icon(
                                        Icons.currency_rupee,
                                        size: 15,
                                      ),
                                      Text(
                                        isCouponApplied
                                            ? finalTotal.round().toString()
                                            : state
                                                .cartListData
                                                .cartListModelData
                                                .cartSummary
                                                .orderTotal
                                                .toString(),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
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
                    ],
                  ),
                ),
              );
            } else {
              return const Center(
                child: Text(
                  'Please Add Products to Cart',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }
          } else if (state is CartListErrorState) {
            return Center(
              child: Text(state.error),
            );
          }
          return Container();
        },
      ),
      bottomNavigationBar: BlocBuilder<CartListBloc, CartListState>(
        builder: (context, state) {
          if (state is CartListLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CartListLoadedState) {
            num orderTotal =
                state.cartListData.cartListModelData.cartSummary.subTotal -
                    (state.cartListData.cartListModelData.cartSummary.subTotal *
                        15 /
                        100);
            num couponDiscount =
                state.cartListData.cartListModelData.cartSummary.subTotal -
                    orderTotal;
            num finalTotal = orderTotal -
                state.cartListData.cartListModelData.cartSummary.discountTotal;
            return Row(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 16,
                  width: MediaQuery.of(context).size.width * 0.5,
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ProductsWidget(),
                        ),
                      );
                    },
                    child: const Center(
                      child: Text('Add More'),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 16,
                  width: MediaQuery.of(context).size.width * 0.5,
                  color: Colors.blue,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => CheckoutScreen(
                            totalAmount: isCouponApplied
                                ? finalTotal.round().toString()
                                : state.cartListData.cartListModelData
                                    .cartSummary.orderTotal
                                    .toString(),
                            subTotal: state.cartListData.cartListModelData
                                .cartSummary.subTotal
                                .toString(),
                            discountTotal: state.cartListData.cartListModelData
                                .cartSummary.discountTotal
                                .toString(),
                            couponDiscount: isCouponApplied
                                ? couponDiscount.round().toString()
                                : state.cartListData.cartListModelData
                                    .cartSummary.couponDiscount
                                    .toString(),
                          ),
                        ),
                      );
                    },
                    child: const Center(
                      child: Text(
                        'Checkout',
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
          } else if (state is CartListErrorState) {
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
