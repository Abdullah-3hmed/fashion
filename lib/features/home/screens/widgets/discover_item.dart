import 'package:e_fashion_flutter/core/utils/assets_manager.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/home_clipped_container.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class DiscoverItem extends StatelessWidget {
  const DiscoverItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Image.asset(
            height: 300.0,
            width: double.infinity,
            AssetsManager.welcomeImage,
            fit: BoxFit.cover,
          ),
        ),
        HomeClippedContainer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Denim Jacket",
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge!.copyWith(color: Colors.white),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  Text(
                    r"$150 ",
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge!.copyWith(color: Colors.white),
                  ),
                  const Spacer(),
                  const SizedBox(width: 28.0),
                  InkWell(
                    onTap: () {},
                    child: Icon(
                      Iconsax.bag_2,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 16.0),
                ],
              ),
            ],
          ),
        ),
        PositionedDirectional(
          top: 16.0,
          end: 16.0,
          child: InkWell(
            onTap: () {},
            child: CircleAvatar(
              radius: 18.0,
              backgroundColor: Colors.white.withValues(alpha: 0.15),
              child: Icon(
                Iconsax.heart,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
