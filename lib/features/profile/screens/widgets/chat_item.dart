import 'package:e_fashion_flutter/features/profile/data/chat/message_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({super.key, required this.messageModel});

  final MessageModel messageModel;

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
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: const BorderRadiusDirectional.only(
                    topStart: Radius.circular(40.0),
                    topEnd: Radius.circular(40.0),
                    bottomEnd: Radius.circular(40.0),
                  ),
                ),
                child: Text(
                  messageModel.content,
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
          DateFormat('hh:mm a').format(DateTime.parse(messageModel.createdAt)),
          style: Theme.of(context).textTheme.labelSmall!.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
    );
  }
}
