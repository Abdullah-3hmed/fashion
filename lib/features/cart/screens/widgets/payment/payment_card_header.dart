import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PaymentCardHeader extends StatelessWidget {
  const PaymentCardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10.0),
        const Icon(
          FontAwesomeIcons.circleCheck,
          color: Colors.green,
          size: 50.0,
        ),
        const SizedBox(height: 10.0),
        Text(
          "Congratulations",
          style: Theme.of(
            context,
          ).textTheme.titleMedium!.copyWith(color: Colors.black),
        ),
        Text(
          "Your order is confirmed",
          style: Theme.of(
            context,
          ).textTheme.titleSmall!.copyWith(color: Colors.black),
        ),
        const SizedBox(height: 18.0),
        const Stack(
          alignment: AlignmentDirectional.center,
          clipBehavior: Clip.none,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: DottedDashedLine(
                    height: 5.0,
                    axis: Axis.horizontal,
                    width: 200.0,
                    dashHeight: 10.0,
                    dashWidth: 7.0,
                    strokeWidth: 1.1,
                    dashSpace: 5.0,
                  ),
                ),
              ],
            ),
            PositionedDirectional(
              start: -16.0,
              child: CircleAvatar(
                radius: 16.0,
                backgroundColor: Colors.black,
              ),
            ),
            PositionedDirectional(
              end: -16.0,
              child: CircleAvatar(
                radius: 16.0,
                backgroundColor: Colors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
