import 'package:auto_route/auto_route.dart';
import 'package:e_fashion_flutter/core/services/service_locator.dart';
import 'package:e_fashion_flutter/core/utils/app_constants.dart';
import 'package:e_fashion_flutter/core/utils/assets_manager.dart';
import 'package:e_fashion_flutter/features/profile/cubit/chat_cubit/chat_cubit.dart';
import 'package:e_fashion_flutter/features/profile/cubit/user_cubit/user_cubit.dart';
import 'package:e_fashion_flutter/features/profile/data/chat/send_message_model.dart';
import 'package:e_fashion_flutter/features/profile/screens/widgets/messages_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax/iconsax.dart';

@RoutePage()
class ChatSupportScreen extends StatefulWidget {
  const ChatSupportScreen({
    super.key,
    required this.receiverId,
    this.chatId = 0,
  });

  final String receiverId;
  final int chatId;


  @override
  State<ChatSupportScreen> createState() => _ChatSupportScreenState();
}

class _ChatSupportScreenState extends State<ChatSupportScreen> {
  late final TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<ChatCubit>()
          ..clearMessage()
          ..getChatHistory(receiverId: widget.receiverId);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AutoLeadingButton(),
        title: const Text("Chat Support"),
      ),
      body: Padding(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            const SizedBox(height: 16.0),
            const Expanded(child: MessagesList()),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      controller.text = value;
                    },
                    controller: controller,
                    minLines: 1,
                    maxLines: 4,
                    onTapOutside: (_) => FocusScope.of(context).unfocus(),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                      hintText: "Message",
                      hintStyle: Theme.of(context).textTheme.bodySmall,
                      filled: true,
                      fillColor:
                          Theme.of(context).colorScheme.surfaceContainerHighest,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    await _sendMessage(context);
                  },
                  icon: SvgPicture.asset(
                    AssetsManager.sendIcon,
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 48.0),
          ],
        ),
      ),
    );
  }

  Future<void> _sendMessage(BuildContext context) async {
    if (controller.text.isNotEmpty) {
      SendMessageModel sendMessageModel = SendMessageModel(
        content: controller.text,
        senderId:
            widget.chatId == 0 ? AppConstants.userId : AppConstants.supportId,
        receiverId: widget.receiverId,
        chatId: widget.chatId,
      );
      controller.clear();
      await context.read<ChatCubit>().sendChatMessage(
        sendMessageModel: sendMessageModel,
      );
    }
  }
}
