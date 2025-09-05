import 'package:e_fashion_flutter/core/utils/assets_manager.dart';
import 'package:e_fashion_flutter/core/utils/show_toast.dart';
import 'package:e_fashion_flutter/features/profile/data/order/order_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.0,
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: 8.0,
        vertical: 10.0,
      ),
      margin: const EdgeInsetsDirectional.symmetric(
        horizontal: 24.0,
        vertical: 8.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Image.asset(
              width: 94.0,
              height: 94.0,
              fit: BoxFit.cover,
              AssetsManager.onProgressImage,
            ),
          ),
          const SizedBox(width: 16.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Order Id",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(width: 10.0),
                  Text(
                    "#${order.orderId}",
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  IconButton(
                    onPressed: () async {
                      await Clipboard.setData(
                        ClipboardData(text: order.orderId.toString()),
                      );
                      showToast(
                        message: "Copied to Clipboard",
                        state: ToastStates.success,
                      );
                    },
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      Icons.copy,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    r"$ Price",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(width: 14.0),
                  Text(
                    r"$"
                    "${order.orderPrice}",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                width: 178.0,
                child: Text(
                  "On Progress",
                  textAlign: TextAlign.end,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
