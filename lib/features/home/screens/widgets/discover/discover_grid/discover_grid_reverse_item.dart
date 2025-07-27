import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_fashion_flutter/core/widgets/modal_bottom_sheet_content.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/discover/discover_grid/discover_grid_clipped_reverse_container.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/discover/discover_grid/discover_grid_clipped_reverse_image.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/discover/discover_grid/discover_top_grid_clipped_reverse_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class DiscoverGridReverseItem extends StatelessWidget {
  const DiscoverGridReverseItem({
    super.key,

    required this.isFirstItem,
  });


  final bool isFirstItem;
  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
    // return Stack(
    //   alignment: AlignmentDirectional.bottomCenter,
    //   children: [
    //     ClipPath(
    //       clipper:
    //           isFirstItem
    //               ? DiscoverTopGridClippedReverseImage()
    //               : DiscoverGridClippedReverseImage(),
    //       child: ClipRRect(
    //         borderRadius:
    //             isFirstItem
    //                 ? const BorderRadiusDirectional.only(
    //                   topEnd: Radius.circular(16.0),
    //                 )
    //                 : BorderRadiusDirectional.zero,
    //         child: CachedNetworkImage(
    //           imageUrl: discoverModel.image,
    //           height: isFirstItem ? 200.0 : 220.0,
    //           width: double.infinity,
    //           fit: BoxFit.cover,
    //           errorWidget: (context, url, error) => const Icon(Icons.error),
    //         ),
    //       ),
    //     ),
    //     CustomPaint(
    //       painter: DiscoverGridClippedReverseContainer(),
    //       child: SizedBox(
    //         height: 72.0,
    //         child: Row(
    //           textDirection: TextDirection.rtl,
    //           children: [
    //             const SizedBox(width: 13.0),
    //             InkWell(
    //               onTap: () async {
    //                 await showModalBottomSheet(
    //                   context: context,
    //                   builder: (context) => const ModalBottomSheetContent(),
    //                 );
    //               },
    //               child: Icon(
    //                 Iconsax.bag_2,
    //                 color: Theme.of(context).colorScheme.primary,
    //               ),
    //             ),
    //             const SizedBox(width: 13.0),
    //             Column(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Text(
    //                   discoverModel.name.length > 7
    //                       ? '${discoverModel.name.substring(0, 7)}...'
    //                       : discoverModel.name,
    //                   maxLines: 1,
    //                   overflow: TextOverflow.ellipsis,
    //                   style: Theme.of(context).textTheme.bodyLarge!.copyWith(
    //                     color: Colors.white,
    //                     height: 1.0,
    //                   ),
    //                 ),
    //                 Text(
    //                   r"$"
    //                   "${discoverModel.price}",
    //                   style: Theme.of(
    //                     context,
    //                   ).textTheme.bodyLarge!.copyWith(color: Colors.white),
    //                 ),
    //               ],
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //     Positioned(
    //       top: 22.0,
    //       right: 10.0,
    //       child: InkWell(
    //         onTap: () {},
    //         child: CircleAvatar(
    //           radius: 16.0,
    //           backgroundColor: Colors.white,
    //           child: Icon(
    //             Iconsax.heart,
    //             color: Theme.of(context).colorScheme.primary,
    //           ),
    //         ),
    //       ),
    //     ),
    //   ],
    // );
  }
}
