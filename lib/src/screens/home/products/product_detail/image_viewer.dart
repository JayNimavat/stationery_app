import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_1/src/screens/home/bloc/product_detail/bloc_product_detail.dart';
import 'package:task_1/src/screens/home/bloc/product_detail/event_product_detail.dart';
import 'package:task_1/src/screens/home/bloc/product_detail/state_product_detail.dart';

class ImageViewer extends StatefulWidget {
  final String productId;
  final String imageUrl;

  const ImageViewer({
    super.key,
    required this.productId,
    required this.imageUrl,
  });

  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductDetailBloc>(
      create: (context) => ProductDetailBloc(),
      child: ImageView(
        productId: widget.productId,
        imageUrl: widget.imageUrl,
      ),
    );
  }
}

class ImageView extends StatefulWidget {
  final String productId;
  final String imageUrl;

  const ImageView({
    super.key,
    required this.productId,
    required this.imageUrl,
  });

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProductDetailBloc>(context)
        .add(ProductDetailDataEvent(productId: widget.productId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailBloc, ProductDetailState>(
      builder: (context, state) {
        if (state is ProductDetailLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ProductDetailLoadedState) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            child: SizedBox(
              height: 550,
              width: 320,
              child: Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  Center(
                    child: InteractiveViewer(
                      boundaryMargin: const EdgeInsets.all(0),
                      child: SizedBox(
                        height: 500,
                        width: 275,
                        child: Image.network(widget.imageUrl),
                      ),
                    ),
                  ),
                  Positioned(
                    top: -22.0,
                    right: -20.0,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                        ),
                        child: const Icon(Icons.close, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (state is ProductDetailErrorState) {
          return Center(
            child: Text(state.error),
          );
        }
        return Container();
      },
    );
  }
}
