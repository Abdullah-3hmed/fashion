import 'package:auto_route/auto_route.dart';
import 'package:e_fashion_flutter/config/router/app_router.dart';
import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/core/payment/payment_manager.dart';
import 'package:e_fashion_flutter/core/services/service_locator.dart';
import 'package:e_fashion_flutter/core/utils/app_constants.dart';
import 'package:e_fashion_flutter/core/utils/show_toast.dart';
import 'package:e_fashion_flutter/core/widgets/primary_button.dart';
import 'package:e_fashion_flutter/features/cart/cubit/cart_cubit/cart_cubit.dart';
import 'package:e_fashion_flutter/features/cart/cubit/cart_cubit/cart_state.dart';
import 'package:e_fashion_flutter/features/cart/cubit/payment_cubit/payment_cubit.dart';
import 'package:e_fashion_flutter/features/cart/cubit/payment_cubit/payment_state.dart';
import 'package:e_fashion_flutter/features/cart/data/cart/cart_model.dart';
import 'package:e_fashion_flutter/features/cart/data/payment/payment_request_model.dart';
import 'package:e_fashion_flutter/features/cart/screens/widgets/cart_item.dart';
import 'package:e_fashion_flutter/features/cart/screens/widgets/no_items_in_cart.dart';
import 'package:e_fashion_flutter/features/cart/screens/widgets/payment/payment_button.dart';
import 'package:e_fashion_flutter/features/profile/cubit/user_cubit/user_cubit.dart';
import 'package:e_fashion_flutter/features/profile/data/user/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CartItemsList extends StatelessWidget   {
  const CartItemsList({super.key});


  static const CartModel dummyCartModel = CartModel(
    size: "**",
    quantity: 1,
    productId: "",
    price: 0.0,
    name: "",
    imageUrl: AppConstants.imageUrl,
    color: "",
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: BlocBuilder<CartCubit, CartState>(
            buildWhen:
                (previous, current) =>
                    previous.cartState != current.cartState ||
                    previous.cartMap != current.cartMap,
            builder: (context, state) {
              switch (state.cartState) {
                case RequestStatus.loading:
                  return Skeletonizer(
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder:
                          (context, index) =>
                              const CartItem(cartModel: dummyCartModel),
                      separatorBuilder: (_, __) => const SizedBox(height: 8.0),
                      itemCount: 5,
                    ),
                  );
                case RequestStatus.success:
                  return state.cartMap.isEmpty
                      ? const NoItemsInCart()
                      : _buildCartList(state);
                case RequestStatus.error:
                  return state.cartMap.isEmpty
                      ? const NoItemsInCart()
                      : _buildCartList(state);
                default:
                  return const SizedBox.shrink();
              }
            },
          ),
        ),
        const SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Sub total :", style: Theme.of(context).textTheme.titleSmall),
            Text(
              r"$"
              "${context.select((CartCubit cubit) => cubit.state.totalPrice)}",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        const PaymentButton(),
        const SizedBox(height: 140.0),
      ],
    );
  }



  ListView _buildCartList(CartState state) {
    final cartItems = state.cartMap.values.toList();
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => CartItem(cartModel: cartItems[index]),
      separatorBuilder: (_, __) => const SizedBox(height: 8.0),
      itemCount: cartItems.length,
    );
  }
}
