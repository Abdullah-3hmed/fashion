import 'package:auto_route/auto_route.dart';
import 'package:e_fashion_flutter/core/widgets/primary_button.dart';
import 'package:e_fashion_flutter/features/cart/screens/widgets/cart_item.dart';
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
      body: Padding(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => const CartItem(),
                separatorBuilder: (_, __) => const SizedBox(height: 8.0),
                itemCount: 10,
              ),
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Sub total :",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Text(
                  r"$600.00",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            PrimaryButton(onPressed: () {}, text: "Checkout"),
            const SizedBox(height: 140.0),
          ],
        ),
      ),
    );
  }
}
