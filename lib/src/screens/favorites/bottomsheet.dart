import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_1/src/screens/favorites/bloc/save_wish/bloc_save_wish.dart';
import 'package:task_1/src/screens/favorites/bloc/save_wish/event_save_wish.dart';
import 'package:task_1/src/screens/favorites/bloc/wish_list/bloc_wish_list.dart';
import 'package:task_1/src/screens/favorites/bloc/wish_list/event_wish_list.dart';
import 'package:task_1/src/screens/favorites/bloc/wish_list/state_wish_list.dart';

class RemoveWishBottomSheet extends StatefulWidget {
  final String wishlistId;
  final String productImage;
  final String productName;
  final String id;
  final Function(bool) onItemRemoved;

  const RemoveWishBottomSheet({
    super.key,
    required this.wishlistId,
    required this.productImage,
    required this.productName,
    required this.id,
    required this.onItemRemoved,
  });

  @override
  State<RemoveWishBottomSheet> createState() => _RemoveWishBottomSheetState();
}

class _RemoveWishBottomSheetState extends State<RemoveWishBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WishListBloc>(
          create: (context) => WishListBloc(),
        ),
        BlocProvider<WishBloc>(
          create: (BuildContext context) => WishBloc(),
        ),
      ],
      child: WishListBottomSheet(
        wishlistId: widget.wishlistId,
        productImage: widget.productImage,
        productName: widget.productName,
        id: widget.id,
        onItemRemoved: widget.onItemRemoved,
      ),
    );
  }
}

class WishListBottomSheet extends StatefulWidget {
  final String wishlistId;
  final String productImage;
  final String productName;
  final String id;
  final Function(bool) onItemRemoved;

  const WishListBottomSheet({
    super.key,
    required this.wishlistId,
    required this.productImage,
    required this.productName,
    required this.id,
    required this.onItemRemoved,
  });

  @override
  State<WishListBottomSheet> createState() => _WishListBottomSheetState();
}

class _WishListBottomSheetState extends State<WishListBottomSheet> {
  _WishListBottomSheetState();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<WishListBloc>(context).add(WishListDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishListBloc, WishListState>(
      builder: (context, state) {
        if (state is WishListLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is WishListLoadedState) {
          return Container(
            height: 242,
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      widget.productImage,
                      height: 120,
                      width: 95,
                      fit: BoxFit.fill,
                    ),
                    const SizedBox(width: 5),
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
                            'Are you sure you want to remove this item from wishlist?',
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
                          Navigator.of(context).pop(false);
                        },
                        child: const SizedBox(
                          height: 50,
                          width: 160,
                          child: Center(
                            child: Text(
                              'NO',
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
                              .add(RemoveWishEvent(
                            wishlistId: widget.id,
                          ));
                          widget.onItemRemoved(true);
                          Navigator.of(context).pop(true);
                        },
                        child: const SizedBox(
                          height: 50,
                          width: 160,
                          child: Center(
                            child: Text(
                              'YES',
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
        } else if (state is WishListErrorState) {
          return Center(
            child: Text(state.error),
          );
        }
        return Container();
      },
    );
  }
}
