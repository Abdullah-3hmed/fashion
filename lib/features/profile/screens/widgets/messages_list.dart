import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/core/utils/app_constants.dart';
import 'package:e_fashion_flutter/features/profile/cubit/chat_cubit/chat_cubit.dart';
import 'package:e_fashion_flutter/features/profile/cubit/chat_cubit/chat_state.dart';
import 'package:e_fashion_flutter/features/profile/cubit/user_cubit/user_cubit.dart';
import 'package:e_fashion_flutter/features/profile/cubit/user_cubit/user_state.dart';
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
                    previous.getChatHistoryState != current.getChatHistoryState ||
                    previous.messageList != current.messageList,
            builder: (context, state) {
              switch (state.getChatHistoryState) {
                case RequestStatus.loading:
                  return const Center(child: CircularProgressIndicator());
                case RequestStatus.success:
                  return state.messageList.isEmpty
                      ? const NoMessagesContent()
                      : ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          if (state.messageList[index].senderId ==
                              AppConstants.userId) {
                            return MyChatItem(
                              messageModel: state.messageList[index],
                            );
                          } else {
                            return ChatItem(
                              messageModel: state.messageList[index],
                            );
                          }
                        },
                        separatorBuilder:
                            (_, __) => const SizedBox(height: 16.0),
                        itemCount: state.messageList.length,
                      );
                case RequestStatus.error:
                  return Center(
                    child: Text(
                      state.getChatHistoryErrorMessage,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  );
                default:
                  return const SizedBox.shrink();
              }
            },
          ),
        ),
      ],
    );
  }
}
