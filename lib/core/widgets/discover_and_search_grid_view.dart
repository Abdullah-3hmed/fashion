import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_fashion_flutter/core/widgets/modal_bottom_sheet_content.dart';
import 'package:e_fashion_flutter/features/home/data/discover_model.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/discover/discover_grid_clipped_container.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/discover/discover_top_grid_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class DiscoverAndSearchGridView extends StatelessWidget {
  const DiscoverAndSearchGridView({super.key, required this.discoverList});

  final List<DiscoverModel> discoverList;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      key: const ValueKey('grid'),
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 0.75,
      ),
      itemCount: discoverList.length,
      itemBuilder:
          (context, index) => Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              ClipPath(
                clipper: DiscoverTopGridImage(),
                child: ClipRRect(
                  borderRadius: const BorderRadiusDirectional.only(
                    topStart: Radius.circular(16.0),
                    topEnd: Radius.circular(16.0),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: discoverList[index].image,
                    height: 200.0,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorWidget:
                        (context, url, error) => const Icon(Icons.error),
                  ),
                ),
              ),
              CustomPaint(
                painter: DiscoverGridClippedContainer(),
                child: SizedBox(
                  height: 72.0,
                  child: Row(
                    children: [
                      const SizedBox(width: 13.0),
                      InkWell(
                        onTap: () async {
                          await showModalBottomSheet(
                            context: context,
                            builder:
                                (context) => const ModalBottomSheetContent(),
                          );
                        },
                        child: Icon(
                          Iconsax.bag_2,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: 13.0),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            discoverList[index].name.length > 10
                                ? '${discoverList[index].name.substring(0, 10)}...'
                                : discoverList[index].name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyLarge!
                                .copyWith(color: Colors.white),
                          ),
                          Text(
                            r"$"
                            "${discoverList[index].price}",
                            style: Theme.of(context).textTheme.bodyLarge!
                                .copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
    );
  }
}
