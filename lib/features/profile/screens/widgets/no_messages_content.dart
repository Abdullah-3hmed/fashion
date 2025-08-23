import 'package:e_fashion_flutter/core/utils/assets_manager.dart';
import 'package:flutter/material.dart';

class NoMessagesContent extends StatelessWidget {
  const NoMessagesContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        Image.asset(width: 165.0, height: 160.0, AssetsManager.chatImage),
        const SizedBox(height: 16.0),
        Text(
          "Feel free to tell us \n how to help you",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const Spacer(),
      ],
    );
  }
}
