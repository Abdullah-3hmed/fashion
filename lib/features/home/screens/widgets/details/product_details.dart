import 'package:auto_route/auto_route.dart';
import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/core/utils/show_toast.dart';
import 'package:e_fashion_flutter/core/utils/toast_states.dart';
import 'package:e_fashion_flutter/core/widgets/primary_button.dart';
import 'package:e_fashion_flutter/features/cart/cubit/cart_cubit.dart';
import 'package:e_fashion_flutter/features/cart/cubit/cart_state.dart';
import 'package:e_fashion_flutter/features/cart/data/cart_model.dart';
import 'package:e_fashion_flutter/features/home/data/home_details/product_details_model.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/details/rating_section.dart';
import 'package:e_fashion_flutter/shared/widgets/colors_available.dart';
import 'package:e_fashion_flutter/shared/widgets/pieces_available.dart';
import 'package:e_fashion_flutter/shared/widgets/sizes_available.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({
    super.key,
    required this.controller,
    required this.productDetailsModel,
  });

  final ScrollController controller;
  final ProductDetailsModel productDetailsModel;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  late String selectedColor;
  late String selectedSize;
  int pieces = 1;

  @override
  void initState() {
    selectedColor = widget.productDetailsModel.parsedColors.first;
    selectedSize = widget.productDetailsModel.parsedSizes.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: widget.controller,
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30.0),
              InkWell(
                onTap: () {
                  context.pop();
                },
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  radius: 24.0,
                  child: Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 24.0),
              Text(
                widget.productDetailsModel.title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                r"$"
                "${widget.productDetailsModel.price}",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 24.0),
              ColorsAvailable(
                colors: widget.productDetailsModel.parsedColors,
                onColorChanged: (color) => selectedColor = color,
              ),
              SizesAvailable(
                sizes: widget.productDetailsModel.parsedSizes,
                onSizeChanged: (size) => selectedSize = size,
              ),
              PiecesAvailable(onPiecesChanged: (int value) => pieces = value),
              Text(
                "lorem ipsum dolor sit amet consectetur. Elit neque integer enim diam rhoncus rhoncus eu ut. Porttitor elementum arcu gravida adipiscing in. Consequat.",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 24.0),
              BlocConsumer<CartCubit, CartState>(
                listenWhen:
                    (previous, current) =>
                        previous.cartState != current.cartState,
                listener: (context, state) {
                  if (state.cartState.isError) {
                    showToast(
                      message: state.cartErrorMessage,
                      state: ToastStates.error,
                    );
                  }
                  if (state.cartState.isSuccess) {
                    showToast(
                      message: "Added to cart",
                      state: ToastStates.success,
                    );
                  }
                },
                buildWhen:
                    (previous, current) =>
                        previous.cartState != current.cartState,
                builder: (context, state) {
                  return PrimaryButton(
                    isLoading: state.cartState.isLoading,
                    icon: Icon(
                      Iconsax.bag_2,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    onPressed: () async {
                      CartModel cartModel = CartModel(
                        productId: widget.productDetailsModel.id,
                        name: widget.productDetailsModel.title,
                        price: widget.productDetailsModel.price,
                        imageUrl: widget.productDetailsModel.imageUrl,
                        color: selectedColor,
                        size: selectedSize,
                        quantity: pieces,
                      );
                      await context.read<CartCubit>().addToCart(
                        cartModel: cartModel,
                      );
                    },
                    text: "Add to bag",
                  );
                },
              ),
              const SizedBox(height: 24.0),
              Text(
                "Rate this product",
                style: Theme.of(context).textTheme.labelMedium,
              ),
              Text(
                "Tell others what you think",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 24.0),
              RatingSection(productDetailsModel: widget.productDetailsModel),
              const SizedBox(height: 40.0),
            ],
          ),
        ),
      ],
    );
  }
}
