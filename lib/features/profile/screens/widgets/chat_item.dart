import 'package:flutter/material.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(
              child: Container(
                padding: const EdgeInsetsDirectional.all(16.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  borderRadius: const BorderRadiusDirectional.only(
                    topStart: Radius.circular(40.0),
                    topEnd: Radius.circular(40.0),
                    bottomEnd: Radius.circular(40.0),
                  ),
                ),
                child: Text(
                  "Lorem ipsum dolor sit amet consectetur. Et nulla non pulvinar sit elit at velit.",
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ),
            const SizedBox(width: 100.0),
          ],
        ),
        const SizedBox(height: 4.0),
        Text(
          " 11:50 AM",
          style: Theme.of(context).textTheme.labelSmall!.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
    );
  }
}
