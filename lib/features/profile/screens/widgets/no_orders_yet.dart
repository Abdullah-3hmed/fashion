import 'package:flutter/material.dart';

class NoOrdersYet extends StatelessWidget {
  const NoOrdersYet({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("No orders yet", style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12.0),
          Text(
            "Once you confirm an \n order we will track it",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
    );
  }
}
