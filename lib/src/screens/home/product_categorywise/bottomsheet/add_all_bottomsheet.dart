import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_1/src/screens/cart/cart.dart';
import 'package:task_1/src/screens/home/bloc/all_add_to_cart/bloc_all_add_cart.dart';
import 'package:task_1/src/screens/home/bloc/all_add_to_cart/event_all_add_to_cart.dart';
import 'package:task_1/src/screens/home/bloc/product_categorywise/bloc_catwise_product.dart';
import 'package:task_1/src/screens/home/bloc/product_categorywise/event_catwise_product.dart';

class AddAllToCartSheet extends StatefulWidget {
  final String standardId;

  const AddAllToCartSheet({
    super.key,
    required this.standardId,
  });

  @override
  State<AddAllToCartSheet> createState() => _AddAllToCartSheetState();
}

class _AddAllToCartSheetState extends State<AddAllToCartSheet> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CatwiseProductBloc>(
          create: (context) => CatwiseProductBloc(),
        ),
        BlocProvider<AllAddToCartBloc>(
          create: (context) => AllAddToCartBloc(),
        ),
      ],
      child: AddAllBottomSheet(
        standardId: widget.standardId,
      ),
    );
  }
}

class AddAllBottomSheet extends StatefulWidget {
  final String standardId;
  const AddAllBottomSheet({
    super.key,
    required this.standardId,
  });

  @override
  State<AddAllBottomSheet> createState() => _AddAllBottomSheetState();
}

class _AddAllBottomSheetState extends State<AddAllBottomSheet> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CatwiseProductBloc>(context)
        .add(CatwiseProductDataEvent(standardId: widget.standardId));
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      snap: true,
      initialChildSize: 0.45,
      builder: (context, scrollController) {
        return Container(
          height: 242,
          padding: const EdgeInsets.all(10),
          child: Column(
            //  mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Icon(Icons.close),
                ),
              ),
              const SizedBox(height: 35),
              const Text(
                "Are you sure you want to add to cart items",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 45),
              const Divider(color: Colors.black45),
              const SizedBox(height: 5),
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop(true);
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
                        Navigator.of(context).pop();
                        BlocProvider.of<AllAddToCartBloc>(context).add(
                            AllAddToCartDataEvent(
                                standardId: widget.standardId));
                        _showToast('All Product added Successfully');
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const CartScreen(),
                          ),
                        );
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
      },
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
