import 'package:e_fashion_flutter/core/utils/assets_manager.dart';
import 'package:e_fashion_flutter/core/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({
    super.key,
    required this.onPressed,
    this.isLoading = false, required this.errorMessage,
  });

  final void Function() onPressed;
  final bool isLoading;
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 2),
          SvgPicture.asset(
            AssetsManager.noInternet,
            width: 120.0,
            height: 100.0,
            colorFilter: ColorFilter.mode(
              Theme.of(context).colorScheme.primary,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(height: 24.0),
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 4.0),
          Text(
            "Please make sure that you are \n connected to the wifi",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const Spacer(),
          PrimaryButton(
            isLoading: isLoading,
            width: 200.0,
            onPressed: onPressed,
            text: "Try Again",
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
