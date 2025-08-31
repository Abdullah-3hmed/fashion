import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:e_fashion_flutter/features/cart/data/payment/payment_success_model.dart';
import 'package:flutter/material.dart';

class PaymentCardBody extends StatelessWidget {
  const PaymentCardBody({super.key, required this.paymentSuccessModel});

  final PaymentSuccessModel paymentSuccessModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 24.0),
        Padding(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 48.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Ordered by : ${paymentSuccessModel.firstName} ${paymentSuccessModel.lastName}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(color: Colors.black),
              ),
              const SizedBox(height: 8.0),
              Text(
               "Date : ${paymentSuccessModel.date}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(color: Colors.black),
              ),
              const SizedBox(height: 8.0),
              Text(
                "Time : ${paymentSuccessModel.time}",
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(color: Colors.black),
              ),
              const SizedBox(height: 8.0),
              Text(
                "Delivery Date : ${paymentSuccessModel.deliveryDate}",
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(color: Colors.black),
              ),
              const SizedBox(height: 20.0),
              const Row(
                children: [
                  Expanded(
                    child: DottedDashedLine(
                      height: 5.0,
                      axis: Axis.horizontal,
                      width: 200.0,
                      dashWidth: 7.0,
                      strokeWidth: 1.3,
                      dashSpace: 5.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Order Price : ",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    r"$"
                    "${paymentSuccessModel.amount}",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 80.0),
      ],
    );
  }
}
