import 'package:auto_route/auto_route.dart';
import 'package:e_fashion_flutter/config/router/app_router.dart';
import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/core/utils/show_toast.dart';
import 'package:e_fashion_flutter/core/widgets/primary_button.dart';
import 'package:e_fashion_flutter/features/cart/cubit/cart_cubit/cart_cubit.dart';
import 'package:e_fashion_flutter/features/cart/cubit/cart_cubit/cart_state.dart';
import 'package:e_fashion_flutter/features/cart/cubit/payment_cubit/payment_cubit.dart';
import 'package:e_fashion_flutter/features/cart/cubit/payment_cubit/payment_state.dart';
import 'package:e_fashion_flutter/features/cart/data/payment/payment_request_model.dart';
import 'package:e_fashion_flutter/features/profile/cubit/user_cubit/user_cubit.dart';
import 'package:e_fashion_flutter/features/profile/data/user/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentButton extends StatelessWidget {
  const PaymentButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentCubit, PaymentState>(
      listenWhen:
          (previous, current) => previous.paymentState != current.paymentState,
      listener: (context, state) {
        if (state.paymentState.isSuccess) {
          context.pushRoute(
            PaymentRoute(paymentResponseModel: state.paymentResponseModel),
          );
        }
        if (state.paymentState.isError) {
          showToast(
            message: state.paymentErrorMessage,
            state: ToastStates.error,
          );
        }
      },
      buildWhen:
          (previous, current) => previous.paymentState != current.paymentState,
      builder: (context, state) {
        return PrimaryButton(
          isLoading: state.paymentState.isLoading,
          onPressed: () async {
            await _pay(context);
          },
          text: "Checkout",
        );
      },
    );
  }

  Future<void> _pay(BuildContext context) async {
    final CartState state = context.read<CartCubit>().state;
    if (state.cartMap.isNotEmpty) {
      if (context.read<UserCubit>().state.userLocation.isEmpty) {
        showToast(
          message: "You Must Set Your Location In Profile Tab!",
          state: ToastStates.error,
        );
        return;
      }
      final UserModel userModel = context.read<UserCubit>().state.userModel;
      final parts = userModel.userName.trim().split(" ");
      final firstName = parts.isNotEmpty ? parts[0] : "N/A";
      final lastName = parts.length > 1 ? parts.sublist(1).join(" ") : "N/A";
      PaymentRequestModel paymentModel = PaymentRequestModel(
        amount: state.totalPrice.toInt(),
        firstName: firstName,
        lastName: lastName,
        email: userModel.email,
        phoneNumber: userModel.phone,
      );
      await context.read<PaymentCubit>().payWithPaymobCart(
        paymentModel: paymentModel,
      );
    }
  }
}
