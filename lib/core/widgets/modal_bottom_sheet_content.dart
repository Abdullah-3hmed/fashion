import 'package:auto_route/auto_route.dart';
import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/core/utils/show_toast.dart';
import 'package:e_fashion_flutter/core/utils/toast_states.dart';
import 'package:e_fashion_flutter/core/widgets/primary_button.dart';
import 'package:e_fashion_flutter/features/cart/cubit/cart_cubit/cart_cubit.dart';
import 'package:e_fashion_flutter/features/cart/cubit/cart_cubit/cart_state.dart';
import 'package:e_fashion_flutter/features/cart/data/cart/cart_model.dart';
import 'package:e_fashion_flutter/shared/widgets/colors_available.dart';
import 'package:e_fashion_flutter/shared/widgets/pieces_available.dart';
import 'package:e_fashion_flutter/shared/widgets/sizes_available.dart';
import 'package:e_fashion_flutter/shared/data/bottom_sheet_model.dart';
import 'package:e_fashion_flutter/shared/data/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class ModalBottomSheetContent extends StatefulWidget {
  const ModalBottomSheetContent({
    super.key,
    required this.bottomSheetModel,
    this.isBottomNav = false,
  });

  final BottomSheetModel bottomSheetModel;
  final bool isBottomNav;

  @override
  State<ModalBottomSheetContent> createState() =>
      _ModalBottomSheetContentState();
}

class _ModalBottomSheetContentState extends State<ModalBottomSheetContent> {
  late String selectedColor;
  late String selectedSize;
  int selectedPieces = 1;

  @override
  void initState() {
    selectedColor = widget.bottomSheetModel.colors.first;
    selectedSize = widget.bottomSheetModel.sizes.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.all(24.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: const BorderRadiusDirectional.only(
          topEnd: Radius.circular(30.0),
          topStart: Radius.circular(30.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.bottomSheetModel.title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(width: 46.0),
              Text(
                r"$"
                "${widget.bottomSheetModel.basePrice}",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
          const SizedBox(height: 30.0),
          ColorsAvailable(
            colors: widget.bottomSheetModel.colors,
            onColorChanged: (String color) => selectedColor = color,
          ),
          const SizedBox(height: 24.0),
          SizesAvailable(
            sizes: widget.bottomSheetModel.sizes,
            onSizeChanged: (String size) => selectedSize = size,
          ),
          const SizedBox(height: 22),
          PiecesAvailable(
            onPiecesChanged: (int pieces) => selectedPieces = pieces,
          ),
          const SizedBox(height: 37),
          BlocConsumer<CartCubit, CartState>(
            listenWhen:
                (previous, current) => previous.cartState != current.cartState,
            listener: (context, state) {
              if (state.cartState.isError) {
                showToast(
                  message: state.cartErrorMessage,
                  state: ToastStates.error,
                );
              }
              if (state.cartState.isSuccess) {
                context.pop();
               if(!widget.isBottomNav) showToast(message: "Add To Cart", state: ToastStates.success);
              }
            },
            buildWhen:
                (previous, current) => previous.cartState != current.cartState,
            builder: (context, state) {
              return PrimaryButton(
                isLoading: state.cartState.isLoading,
                onPressed: () async {
                  CartModel cartModel = CartModel(
                    color: selectedColor,
                    imageUrl: widget.bottomSheetModel.imageUrl,
                    name: widget.bottomSheetModel.title,
                    price: widget.bottomSheetModel.basePrice,
                    productId: widget.bottomSheetModel.id,
                    quantity: selectedPieces,
                    size: selectedSize,
                  );
                  await context.read<CartCubit>().addToCart(
                    cartModel: cartModel,
                  );
                },
                text: "Add to bag",
                icon: Icon(
                  Iconsax.bag_2,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
