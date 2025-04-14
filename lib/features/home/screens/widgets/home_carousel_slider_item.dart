import 'package:auto_route/auto_route.dart';
import 'package:e_fashion_flutter/config/router/app_router.dart';
import 'package:e_fashion_flutter/core/utils/assets_manager.dart';
import 'package:e_fashion_flutter/core/widgets/primary_button.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/colors_available.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/home_clipped_container.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/pieces_available.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/sizes_available.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class HomeCarouselSliderItem extends StatelessWidget {
  const HomeCarouselSliderItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            InkWell(
              onTap: () {
                context.pushRoute(const DetailsRoute());
              },
              child: Container(
                width: double.infinity,
                height: 180.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: Image.asset(AssetsManager.testImage).image,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                context.pushRoute(const DetailsRoute());
              },
              child: HomeClippedContainer(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Denim Jacket",
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge!.copyWith(color: Colors.white),
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: r"$200 ",
                            style: Theme.of(
                              context,
                            ).textTheme.bodyLarge!.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              overflow: TextOverflow.ellipsis,
                              decoration: TextDecoration.lineThrough,
                              decorationColor:
                                  Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          TextSpan(
                            text: r"  $150 ",
                            style: Theme.of(context).textTheme.bodyLarge!
                                .copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            PositionedDirectional(
              bottom: 0.0,
              end: 0.0,
              child: IconButton(
                onPressed: () async {
                  await showModalBottomSheet(
                    context: context,
                    useRootNavigator: true,
                    builder:
                        (context) => Container(
                          padding: const EdgeInsetsDirectional.all(24.0),
                          decoration: BoxDecoration(
                            color:
                                Theme.of(
                                  context,
                                ).colorScheme.surfaceContainerHighest,
                            borderRadius: const BorderRadiusDirectional.only(
                              topEnd: Radius.circular(30.0),
                              topStart: Radius.circular(30.0),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Winter Jacket",
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  const SizedBox(width: 46.0),
                                  Text(
                                    r"$200",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 30.0),
                              ColorsAvailable(
                                onColorChanged:
                                    (index) => debugPrint(index.toString()),
                              ),
                              const SizedBox(height: 24.0),
                              SizesAvailable(
                                onColorChanged: (size) {
                                  debugPrint(size);
                                },
                              ),
                              const SizedBox(height: 22),
                              PiecesAvailable(
                                onPiecesChanged: (value) {
                                  debugPrint(value.toString());
                                },
                              ),
                              const SizedBox(height: 37),
                              PrimaryButton(
                                onPressed: () {},
                                text: "Add to bag",
                                icon: const Icon(Iconsax.bag_2),
                              ),
                            ],
                          ),
                        ),
                  );
                },
                icon: Icon(
                  Iconsax.bag_2,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            PositionedDirectional(
              top: 0.0,
              end: 0.0,
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Iconsax.heart,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
