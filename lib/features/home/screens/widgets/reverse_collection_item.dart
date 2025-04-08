import 'package:e_fashion_flutter/core/utils/assets_manager.dart';
import 'package:flutter/material.dart';

class ReverseCollectionItem extends StatelessWidget {
  const ReverseCollectionItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 186.0,
      width: double.infinity,
      padding: const EdgeInsetsDirectional.only(
        start: 40.0,
        top: 8.0,
        bottom: 8.0,
        end: 8.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
      ),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              width: 100.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "White Dress",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(width: 16.0),
                  Text(
                    "Lorem ipsum dolor sit amet consectetur. Porttitor ipsum non est dolor nibh vulputate laoreet nunc." *
                        3,
                    maxLines: 8,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Image.asset(fit: BoxFit.cover, AssetsManager.welcomeImage),
            ),
          ),
        ],
      ),
    );
  }
}
