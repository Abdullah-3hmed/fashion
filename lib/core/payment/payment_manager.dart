import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:multi_payment_gateway/stripe_payment_kit.dart';

class PaymentManager {
  static Future<void> payWithStripe({required int amount}) async {
    StripeSetup.setup(publishableKey: dotenv.env["Stripe_Publishable_Key"]!);
    var token = "${dotenv.env["Stripe_Secret_Key"]}";
    final SetupStripePayment intent = SetupStripePayment(
      token: token,
      amount: amount,
      merchantDisplayName: "Abdullah",
    );
    try {
      await StripeService.instance.pay(setupPayment: intent);
      debugPrint("Payment Successful");
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
