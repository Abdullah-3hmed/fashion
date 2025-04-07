import 'package:auto_route/auto_route.dart';
import 'package:e_fashion_flutter/config/router/app_router.dart';
import 'package:e_fashion_flutter/core/widgets/primary_button.dart';
import 'package:e_fashion_flutter/features/auth/screens/widgets/auth_background_image_and_logo.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

@RoutePage()
class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackgroundImageAndLogo(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Text(
                  "Email verification",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8.0),
                Text(
                  "Enter the 6 digital code the sent \n to your email address",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 46.0),
                Pinput(
                  length: 6,
                  onCompleted: (value) {
                    debugPrint(value);
                  },
                  onSubmitted: (value) {
                    debugPrint(value);
                  },
                  defaultPinTheme: PinTheme(
                    width: 40.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 74.0),
                PrimaryButton(
                  onPressed: () {
                    context.pushRoute(const ResetPasswordRoute());
                  },
                  text: "Verify and proceed",
                ),
                const SizedBox(height: 50.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
