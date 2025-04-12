import 'package:auto_route/auto_route.dart';
import 'package:e_fashion_flutter/core/utils/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

@RoutePage()
class ChatSupportScreen extends StatelessWidget {
  const ChatSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chat Support")),
      body: Column(
        children: [
          const Spacer(),
          Image.asset(width: 142.0, height: 140.0, AssetsManager.chatImage),
          const SizedBox(height: 16.0),
          Text(
            "Feel free to tell us \n how to help you",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsetsDirectional.only(
              start: 24.0,
              end: 24.0,
              bottom: 48.0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
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
                  onPressed: () {},
                  icon: SvgPicture.asset(AssetsManager.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
