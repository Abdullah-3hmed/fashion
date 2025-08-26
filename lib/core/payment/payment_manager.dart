// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:multi_payment_gateway/stripe_payment_kit.dart';
//
// class PaymentManager {
//   static Future<void> payWithPaymob(BuildContext context,int amount) async {
//     final SetupPaymobPayment setupPayment = SetupPaymobPayment(
//         context: context,
//         frameId: "792713",
//         amount: amount,
//         items: [],
//         integrationId: int.parse("${dotenv.env["INTEGRATION_ID"]}"),
//         apiKey: "${dotenv.env["PAYMOB_API_KEY"]}"
//     );
//     await PaymobPaymentService.instance.pay(setupPayment: setupPayment);
//   }
// }
