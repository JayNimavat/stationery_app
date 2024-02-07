import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_1/src/screens/cart/bloc/cart/cart_bloc.dart';
import 'package:task_1/src/screens/cart/bloc/cart/cart_event.dart';
import 'package:task_1/src/screens/cart/bloc/cart_list/bloc_cart_list.dart';
import 'package:task_1/src/screens/cart/bloc/cart_list/event_cart_list.dart';
import 'package:task_1/src/screens/favorites/bloc/save_wish/bloc_save_wish.dart';
import 'package:task_1/src/screens/favorites/bloc/save_wish/event_save_wish.dart';

class CartBottomSheet extends StatefulWidget {
  final String productId;
  final String productImage;
  final String productName;

  const CartBottomSheet({
    super.key,
    required this.productId,
    required this.productImage,
    required this.productName,
  });

  @override
  State<CartBottomSheet> createState() => _CartBottomSheetState();
}

class _CartBottomSheetState extends State<CartBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CartBloc>(
          create: (context) => CartBloc(),
        ),
        BlocProvider<WishBloc>(
          create: (BuildContext context) => WishBloc(),
        ),
        // BlocProvider<CartListBloc>(
        //   create: (context) => CartListBloc(),
        // ),
      ],
      child: CartListBottomSheet(
        productId: widget.productId,
        productImage: widget.productImage,
        productName: widget.productName,
      ),
    );
  }
}

class CartListBottomSheet extends StatefulWidget {
  final String productId;
  final String productImage;
  final String productName;

  const CartListBottomSheet({
    super.key,
    required this.productId,
    required this.productImage,
    required this.productName,
  });

  @override
  State<CartListBottomSheet> createState() => _CartListBottomSheetState();
}

class _CartListBottomSheetState extends State<CartListBottomSheet> {
  @override
  void initState() {
    super.initState();
    // BlocProvider.of<CartListBloc>(context).add(CartListDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 242,
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                //  item['image'], // Use the item's image
                widget.productImage,
                height: 130,
                width: 95,
                fit: BoxFit.fill,
              ),
              const SizedBox(width: 7),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.productName.length > 25
                        ? '${widget.productName.substring(0, 25)}...'
                        : widget.productName,
                    style: const TextStyle(fontSize: 13),
                  ),
                  const SizedBox(height: 8),
                  const SizedBox(
                    width: 210,
                    child: Text(
                      'Are you sure you want to move this item from bag?',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black45,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Icon(Icons.close),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(color: Colors.black45),
          const SizedBox(height: 5),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    BlocProvider.of<CartBloc>(context).add(RemoveCartEvent(
                      productId: widget.productId,
                    ));
                    _showToast('Cart Item removed');
                    Navigator.of(context).pop(true);
                  },
                  child: const SizedBox(
                    height: 50,
                    width: 160,
                    child: Center(
                      child: Text(
                        'REMOVE',
                        style: TextStyle(
                          color: Colors.black45,
                        ),
                      ),
                    ),
                  ),
                ),
                const VerticalDivider(
                  color: Colors.black45,
                ),
                InkWell(
                  onTap: () {
                    BlocProvider.of<WishBloc>(context)
                        .add(SaveWishDataEvent(productId: widget.productId));
                    _showToast('Save Wishlist Successfully...!');
                    BlocProvider.of<CartBloc>(context).add(RemoveCartEvent(
                      productId: widget.productId,
                    ));
                    _showToast('Cart Item removed');
                    //   _showToast('This item is already added');
                    Navigator.of(context).pop(true);
                  },
                  child: const SizedBox(
                    height: 50,
                    width: 160,
                    child: Center(
                      child: Text(
                        'MOVE TO WISHLIST',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
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

// BlocBuilder<WishListBloc, WishListState>(
//       builder: (context, state) {
//         if (state is WishListLoadingState) {
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         } else if (state is WishListLoadedState) {
//           return
//         } else if (state is WishListErrorState) {
//           return Center(
//             child: Text(state.error),
//           );
//         }
//         return Container();
//       },
//     );
