import 'package:e_fashion_flutter/features/profile/data/chat/message_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyChatItem extends StatelessWidget {
  const MyChatItem({super.key, required this.messageModel});

  final MessageModel messageModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(width: 100.0),
            Flexible(
              child: Container(
                padding: const EdgeInsetsDirectional.all(16.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: const BorderRadiusDirectional.only(
                    topStart: Radius.circular(40.0),
                    topEnd: Radius.circular(40.0),
                    bottomStart: Radius.circular(40.0),
                  ),
                ),
                child: Text(
                  messageModel.content,
                  textAlign: TextAlign.end,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4.0),
        // Align(
        //   alignment: AlignmentDirectional.centerEnd,
        //   child: Text(
        //     DateFormat(
        //       'hh:mm a',
        //     ).format(DateTime.parse(messageModel.createdAt)),
        //     style: Theme.of(context).textTheme.labelSmall!.copyWith(
        //       color: Theme.of(context).colorScheme.primary,
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
