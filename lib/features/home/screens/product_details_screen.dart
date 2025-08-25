import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_fashion_flutter/core/services/service_locator.dart';
import 'package:e_fashion_flutter/core/widgets/custom_cached_network_image.dart';
import 'package:e_fashion_flutter/features/home/cubit/product_details_cubit/product_details_cubit.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/details/details_clipped_container.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/discover/details_container_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ProductDetailsScreen extends StatefulWidget implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider(
    create: (context) =>
    getIt<ProductDetailsCubit>()..getProductDetails(productId: productId),
    child: this,
  );

  const ProductDetailsScreen({
    super.key,
    required this.imageUrl,
    required this.productId,
  });

  final String imageUrl;
  final String productId;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final ValueNotifier<bool> isClipped = ValueNotifier(true);

  @override
  void dispose() {
    isClipped.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: CustomCachedNetworkImage(
              imageUrl: widget.imageUrl,
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.53,
            minChildSize: 0.47,
            builder: (context, scrollController) {
              return NotificationListener<DraggableScrollableNotification>(
                onNotification: (notification) {
                  final newIsClipped = notification.extent < 0.5;
                  if (newIsClipped != isClipped.value) {
                    isClipped.value = newIsClipped;
                  }
                  return true;
                },
                child: ValueListenableBuilder<bool>(
                  valueListenable: isClipped,
                  child: DetailsContainerContent(
                    controller: scrollController,
                    productId: widget.productId,
                  ),
                  builder: (context, value, child) {
                    return DetailsClippedContainer(
                      isClipped: value,
                      child: child!,
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
