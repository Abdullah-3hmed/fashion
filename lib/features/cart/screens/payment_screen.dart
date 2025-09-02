import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:e_fashion_flutter/config/router/app_router.dart';
import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/core/services/service_locator.dart';
import 'package:e_fashion_flutter/core/utils/show_toast.dart';
import 'package:e_fashion_flutter/features/cart/cubit/cart_cubit/cart_cubit.dart';
import 'package:e_fashion_flutter/features/cart/cubit/payment_cubit/payment_cubit.dart';
import 'package:e_fashion_flutter/features/cart/cubit/payment_cubit/payment_state.dart';
import 'package:e_fashion_flutter/features/cart/data/payment/payment_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

@RoutePage()
class PaymentScreen extends StatelessWidget implements AutoRouteWrapper {
  const PaymentScreen({super.key, required this.paymentResponseModel});

  final PaymentResponseModel paymentResponseModel;

  @override
  Widget wrappedRoute(BuildContext context) =>
      BlocProvider(create: (context) => getIt<PaymentCubit>(), child: this);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentCubit, PaymentState>(
      listenWhen:
          (previous, current) =>
              previous.getPaymentStatus != current.getPaymentStatus,
      listener: (context, state) {
        if (state.getPaymentStatus.isSuccess &&
            state.paymentSuccessModel.success) {
          context.replaceRoute(
            PaymentSuccessRoute(paymentSuccessModel: state.paymentSuccessModel),
          );
          context.read<CartCubit>().clearCart();
        }
        if (state.getPaymentStatus.isSuccess &&
            !state.paymentSuccessModel.success) {
          // TODO: Handle this screen with your own vision
        }
      },
      buildWhen: (_, _) => false,
      builder:
          (context, state) => Scaffold(
            body: InAppWebView(
              initialUrlRequest: URLRequest(
                url: WebUri(paymentResponseModel.url),
              ),
              onLoadStop: (_, url) {
                _handlePaymentResult(url, context, state);
              },
              // onUpdateVisitedHistory: (_, url, _) {
              //   _handlePaymentResult(url, context);
              // },
            ),
          ),
    );
  }

  void _handlePaymentResult(
    WebUri? url,
    BuildContext context,
    PaymentState state,
  ) {
    if (url != null &&
        url.queryParameters.containsKey("success") &&
        url.queryParameters["success"] == "true") {
      context.read<PaymentCubit>().getPaymentStatus(
        orderId: paymentResponseModel.orderId,
      );
    } else if (url != null &&
        url.queryParameters.containsKey("success") &&
        url.queryParameters["success"] == "false") {
      context.read<PaymentCubit>().getPaymentStatus(
        orderId: paymentResponseModel.orderId,
      );
      showToast(
        message: state.getPaymentStatusErrorMessage,
        state: ToastStates.error,
      );
    }
  }
}
