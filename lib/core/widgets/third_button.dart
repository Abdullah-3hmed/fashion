import 'package:e_fashion_flutter/core/utils/assets_manager.dart';
import 'package:flutter/material.dart';

class ThirdButton extends StatelessWidget {
  const ThirdButton({super.key, required this.onPressed, required this.text});

  final void Function() onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32.0,
      child: ElevatedButton(
        style: ButtonStyle(
          padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.symmetric(horizontal: 2.0, vertical: 8.0),
          ),
          backgroundColor: WidgetStateProperty.all<Color>(
            Theme.of(context).colorScheme.secondary,
          ),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          children: [
            Image.asset(AssetsManager.applyFilter),
            Text(
              text,
              style: Theme.of(
                context,
              ).textTheme.labelSmall!.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
