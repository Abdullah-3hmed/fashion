import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/core/utils/app_constants.dart';
import 'package:e_fashion_flutter/features/profile/cubit/chat_cubit/chat_cubit.dart';
import 'package:e_fashion_flutter/features/profile/cubit/chat_cubit/chat_state.dart';
import 'package:e_fashion_flutter/features/profile/data/chat/message_model.dart';
import 'package:e_fashion_flutter/features/profile/screens/widgets/chat_item.dart';
import 'package:e_fashion_flutter/features/profile/screens/widgets/my_chat_item.dart';
import 'package:e_fashion_flutter/features/profile/screens/widgets/no_messages_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          child: BlocBuilder<ChatCubit, ChatState>(
            buildWhen:
                (previous, current) =>
                    previous.getChatHistoryState !=
                        current.getChatHistoryState ||
                    previous.messages != current.messages,
            builder: (context, state) {
              switch (state.getChatHistoryState) {
                case RequestStatus.loading:
                  return const Center(child: CircularProgressIndicator());
                case RequestStatus.success:
                  return _buildChatBody(state);
                case RequestStatus.error:
                  return _buildChatBody(state);
                default:
                  return const SizedBox.shrink();
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildChatBody(ChatState state) {
    return state.messages.isEmpty
        ? const NoMessagesContent()
        : ListView.separated(
          reverse: true,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            final int reverseIndex = state.messages.length - 1 - index;
            final MessageModel message = state.messages[reverseIndex];
            if (message.senderId == AppConstants.userId) {
              return MyChatItem(
                key: ValueKey(message.messageId),
                messageModel: message,
              );
            } else {
              return ChatItem(
                key: ValueKey(message.messageId),
                messageModel: message,
              );
            }
          },
          separatorBuilder: (_, _) => const SizedBox(height: 16.0),
          itemCount: state.messages.length,
          cacheExtent: 200,
        );
  }
}
