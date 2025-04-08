import 'package:auto_route/auto_route.dart';
import 'package:e_fashion_flutter/core/utils/assets_manager.dart';
import 'package:e_fashion_flutter/core/widgets/secondary_button.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/collection_item.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/reverse_collection_item.dart';
import 'package:flutter/material.dart';

@RoutePage()
class CollectionScreen extends StatelessWidget {
  const CollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Summer Collection",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 16.0,
            ),
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemCount: 6,
              separatorBuilder:
                  (context, index) => const SizedBox(height: 16.0),
              itemBuilder:
                  (context, index) =>
                      index % 2 == 0
                          ? const CollectionItem()
                          : const ReverseCollectionItem(),
            ),
          ),
          Image.asset(
            width: double.infinity,
            fit: BoxFit.cover,
            AssetsManager.collectionClippedContainer,
          ),
          PositionedDirectional(
            bottom: 100.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  r"$350",
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium!.copyWith(color: Colors.white),
                ),
                const SizedBox(width: 16.0),
                SecondaryButton(
                  onPressed: () {},
                  text: "Buy collection",
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
