import 'package:auto_route/auto_route.dart';
import 'package:e_fashion_flutter/core/widgets/secondary_button.dart';
import 'package:e_fashion_flutter/features/cart/data/payment/payment_success_model.dart';
import 'package:e_fashion_flutter/features/cart/screens/widgets/payment/payment_card_body.dart';
import 'package:e_fashion_flutter/features/cart/screens/widgets/payment/payment_card_header.dart';
import 'package:flutter/material.dart';

@RoutePage()
class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({super.key, required this.paymentSuccessModel});
final PaymentSuccessModel paymentSuccessModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Text(
                "ORDER RECEIPT",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 40.0),
              Card(
                color: const Color(0xFFF9F9FC),
                child: Column(
                  children: [
                    const PaymentCardHeader(),
                     PaymentCardBody(paymentSuccessModel: paymentSuccessModel,),
                    SecondaryButton(
                      onPressed: () {
                        context.pop();
                      },
                      width: 170.0,
                      text: "Go Back",
                      backgroundColor: const Color(0xFF526070),
                    ),
                    const SizedBox(height: 40.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
