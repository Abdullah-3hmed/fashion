import 'package:e_fashion_flutter/core/utils/assets_manager.dart';
import 'package:e_fashion_flutter/core/widgets/modal_bottom_sheet_content.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:solar_icons/solar_icons.dart';

class FavoriteItem extends StatelessWidget {
  const FavoriteItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadiusDirectional.circular(16.0),
              child: Image.asset(
                width: double.infinity,
                height: 200.0,
                AssetsManager.welcomeImage,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              "Black women shirt",
              style: Theme.of(context).textTheme.labelMedium,
            ),
            Text(r"$200", style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
        PositionedDirectional(
          bottom: 40.0,
          child: InkWell(
            onTap: () async {
              await showModalBottomSheet(
                context: context,
                useRootNavigator: true,
                builder: (context) => const ModalBottomSheetContent(),
              );
            },
            child: CircleAvatar(
              radius: 18.0,
              child: CircleAvatar(
                radius: 16.0,
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: Icon(
                  Iconsax.bag_2,
                  size: 16.0,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
          ),
        ),
        PositionedDirectional(
          end: 6.0,
          top: 6.0,
          child: IconButton(
            onPressed: () {},
            icon: Icon(
              SolarIconsBold.heart,
              size: 30.0,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
