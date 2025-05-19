import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_fashion_flutter/config/router/app_router.dart';
import 'package:e_fashion_flutter/core/widgets/secondary_button.dart';
import 'package:e_fashion_flutter/features/home/cubit/home_cubit.dart';
import 'package:e_fashion_flutter/features/home/data/collection_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key, this.collections = const []});

  final List<CollectionModel> collections;

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  late final PageController controller;

  @override
  void initState() {
    controller = PageController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final collections = widget.collections;
    return SizedBox(
      height: 320,
      width: double.infinity,
      child: Stack(
        children: [
          PageView.builder(
            controller: controller,
            itemCount: collections.length,
            itemBuilder:
                (context, index) => ClipRRect(
                  key: ValueKey(index),
                  borderRadius: const BorderRadiusDirectional.only(
                    bottomStart: Radius.circular(32.0),
                    bottomEnd: Radius.circular(32.0),
                  ),
                  child: Stack(
                    children: [
                      CachedNetworkImage(
                        imageUrl: collections[index].imageUrl,
                        fit: BoxFit.cover,
                        height: 320,
                        width: double.infinity,
                      ),
                      PositionedDirectional(
                        start: 16.0,
                        bottom: 66.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              collections[index].title,
                              style: Theme.of(context).textTheme.titleMedium!
                                  .copyWith(color: Colors.white),
                            ),
                            const SizedBox(height: 8.0),
                            Container(
                              width: 75.0,
                              height: 1.84,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2.0,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              collections[index].discount,
                              style: Theme.of(context).textTheme.displayLarge!
                                  .copyWith(color: Colors.white),
                            ),
                            Text(
                              collections[index].subTitle,
                              style: Theme.of(context).textTheme.titleMedium!
                                  .copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      PositionedDirectional(
                        bottom: 32.0,
                        end: 16.0,
                        child: SecondaryButton(
                          onPressed: () async {
                            context.pushRoute(
                              CollectionRoute(
                                collectionName: collections[index].title,
                              ),
                            );
                            debugPrint(
                              "collection ID : ${collections[index].id}",
                            );
                            await context
                                .read<HomeCubit>()
                                .getCollectionDetails(
                                  collectionId: collections[index].id,
                                  price: collections[index].price,
                                );
                          },
                          text: "Shop now",
                        ),
                      ),
                    ],
                  ),
                ),
          ),
          PositionedDirectional(
            bottom: 24.0,
            start: 24.0,
            child: SmoothPageIndicator(
              controller: controller,
              count: collections.length,
              effect: const ExpandingDotsEffect(
                dotWidth: 30.0,
                dotHeight: 4.0,
                activeDotColor: Colors.white,
                dotColor: Colors.white60,
                expansionFactor: 1.25,
              ),
              onDotClicked: (index) {
                controller.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeInOut,
                );
              },
            ),
          ),
          PositionedDirectional(
            top: 54.0,
            start: 24.0,
            end: 24.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    context.pushRoute(const SearchRoute());
                  },
                  icon: const Icon(
                    Iconsax.search_normal_1,
                    color: Colors.white,
                    size: 24.0,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    context.pushRoute(const NotificationRoute());
                  },
                  icon: const Icon(Iconsax.notification, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
