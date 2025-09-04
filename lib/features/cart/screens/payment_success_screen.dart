import 'package:auto_route/auto_route.dart';
import 'package:e_fashion_flutter/core/widgets/secondary_button.dart';
import 'package:e_fashion_flutter/features/cart/cubit/cart_cubit/cart_cubit.dart';
import 'package:e_fashion_flutter/features/cart/data/payment/payment_success_model.dart';
import 'package:e_fashion_flutter/features/cart/screens/widgets/payment/payment_card_body.dart';
import 'package:e_fashion_flutter/features/cart/screens/widgets/payment/payment_card_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class PaymentSuccessScreen extends StatefulWidget {
  const PaymentSuccessScreen({super.key, required this.paymentSuccessModel});
final PaymentSuccessModel paymentSuccessModel;

  @override
  State<PaymentSuccessScreen> createState() => _PaymentSuccessScreenState();
}

class _PaymentSuccessScreenState extends State<PaymentSuccessScreen> {
  @override
  void initState() {
   WidgetsBinding.instance.addPostFrameCallback((_) {
    context.read<CartCubit>().clearCart();
   });
    super.initState();
  }
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
                     PaymentCardBody(paymentSuccessModel: widget.paymentSuccessModel,),
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
