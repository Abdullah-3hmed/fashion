import 'package:auto_route/auto_route.dart';
import 'package:e_fashion_flutter/core/utils/assets_manager.dart';
import 'package:e_fashion_flutter/features/profile/cubit/user_cubit.dart';
import 'package:e_fashion_flutter/features/profile/screens/widgets/messages_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax/iconsax.dart';

@RoutePage()
class ChatSupportScreen extends StatefulWidget {
  const ChatSupportScreen({super.key});

  @override
  State<ChatSupportScreen> createState() => _ChatSupportScreenState();
}

class _ChatSupportScreenState extends State<ChatSupportScreen> {
  String message = "";
  late final TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
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
            //const NoMessagesContent(),
            const Expanded(child: MessagesList()),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      message = value;
                    },
                    controller: controller,
                    minLines: 1,
                    maxLines: 4,
                    onTapOutside: (event) => FocusScope.of(context).unfocus(),
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
                    if (message.isNotEmpty) {
                      await context.read<UserCubit>().sendMessage(
                        message: message,
                      );
                    }
                    message = "";
                    controller.clear();
                    // setState(() {});
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
}
