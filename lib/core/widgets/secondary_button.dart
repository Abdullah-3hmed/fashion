import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.backgroundColor,
    this.isLoading = false,
  });

  final void Function() onPressed;
  final String text;
  final Color? backgroundColor;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42.0,
      child: ElevatedButton(
        style: ButtonStyle(
          padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          ),
          backgroundColor: WidgetStateProperty.all<Color>(
            backgroundColor ?? Theme.of(context).colorScheme.secondary,
          ),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.0),
                bottomRight: Radius.circular(12.0),
                topRight: Radius.circular(80.0),
                bottomLeft: Radius.circular(80.0),
              ),
            ),
          ),
        ),
        onPressed: onPressed,
        child:
            isLoading
                ? const SizedBox(
                  width: 33.0,
                  child: SpinKitThreeBounce(
                    color: Colors.white,
                    size: 20.0,
                    duration: Duration(milliseconds: 900),
                  ),
                )
                : Text(
                  text,
                  style: Theme.of(
                    context,
                  ).textTheme.labelMedium!.copyWith(color: Colors.white),
                ),
      ),
    );
  }
}
