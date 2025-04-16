import 'package:auto_route/auto_route.dart';
import 'package:e_fashion_flutter/features/cart/screens/widgets/no_items_in_cart.dart';
import 'package:flutter/material.dart';

@RoutePage()
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Shopping Bag",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: const Padding(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 24.0),
        child: NoItemsInCart(),
      ),
    );
  }
}
