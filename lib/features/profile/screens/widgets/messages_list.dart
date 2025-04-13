import 'package:e_fashion_flutter/features/profile/screens/widgets/chat_item.dart';
import 'package:e_fashion_flutter/features/profile/screens/widgets/my_chat_item.dart';
import 'package:flutter/material.dart';

class MessagesList extends StatelessWidget {
  const MessagesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Icon(
              Icons.lock_outline_rounded,
              size: 16.0,
              color: Color(0xFFD4BEE6),
            ),
            const SizedBox(width: 8.0),
            Flexible(
              child: Text(
                "Message and calls are end-to end encrypted, no one outside of this chat can read them ",
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.labelSmall!.copyWith(fontSize: 10.0),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        Expanded(
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              if (index % 2 == 0) {
                return const MyChatItem();
              } else {
                return const ChatItem();
              }
            },
            separatorBuilder: (_, __) => const SizedBox(height: 16.0),
            itemCount: 20,
          ),
        ),
      ],
    );
  }
}
