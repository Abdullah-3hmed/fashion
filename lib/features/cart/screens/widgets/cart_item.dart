import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/core/utils/assets_manager.dart';
import 'package:e_fashion_flutter/core/utils/color_map.dart';
import 'package:e_fashion_flutter/core/utils/show_toast.dart';
import 'package:e_fashion_flutter/core/utils/toast_states.dart';
import 'package:e_fashion_flutter/core/widgets/custom_cached_network_image.dart';
import 'package:e_fashion_flutter/features/cart/cubit/cart_cubit.dart';
import 'package:e_fashion_flutter/features/cart/cubit/cart_state.dart';
import 'package:e_fashion_flutter/features/cart/data/cart_model.dart';
import 'package:e_fashion_flutter/features/cart/screens/widgets/cart_item_count.dart';
import 'package:e_fashion_flutter/shared/widgets/pieces_available.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key, required this.cartModel});

  final CartModel cartModel;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.error,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: const Icon(Iconsax.trash, color: Colors.white, size: 24.0),
      ),
      onDismissed: (_) async{
        await context.read<CartCubit>().deleteFromCart(productId: cartModel.productId);
      },
      key: ValueKey(cartModel.productId),
      child: Container(
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: 8.0,
          vertical: 10.0,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadiusDirectional.circular(16.0),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadiusDirectional.circular(16.0),
              child: CustomCachedNetworkImage(
                imageUrl: cartModel.imageUrl,
                width: 90.0,
                height: 100.0,
              ),
            ),
            const SizedBox(width: 24.0),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cartModel.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 4.0),
                Text(
                  "Size : ${cartModel.size}",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 4.0),
                Row(
                  children: [
                    Text("Color", style: Theme.of(context).textTheme.bodySmall),
                    const SizedBox(width: 8.0),
                     CircleAvatar(
                      radius: 8.0,
                      backgroundColor: Color(colorHexMap[cartModel.color]??0xFF000000),
                    ),
                  ],
                ),
                Row(
                  children: [
                    BlocSelector<CartCubit, CartState, num>(
                      selector:
                          (state) =>
                              state.cartMap[cartModel.productId]?.totalPrice ??
                              0,
                      builder: (context, state) {
                        return Text(
                          r"$"
                          "$state",
                          style: Theme.of(context).textTheme.bodySmall,
                        );
                      },
                    ),
                    const SizedBox(width: 16.0),
                    CartItemCounter(
                      numberOfPieces: cartModel.quantity,
                      onChanged: ({required int value, required bool isIncrement})  {
                        if (isIncrement) {
                          context.read<CartCubit>().incrementQuantity(value, cartModel.productId);
                        } else {
                          context.read<CartCubit>().decrementQuantity(value, cartModel.productId);
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
