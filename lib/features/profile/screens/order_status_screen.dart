import 'package:auto_route/auto_route.dart';
import 'package:e_fashion_flutter/features/profile/screens/widgets/order_item.dart';
import 'package:flutter/material.dart';

@RoutePage()
class OrderStatusScreen extends StatelessWidget {
  const OrderStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order Status',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => const OrderItem(),
        itemCount: 10,
      ),
    );
  }
}
