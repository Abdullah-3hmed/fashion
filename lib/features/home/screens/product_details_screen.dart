import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/details/details_clipped_container.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/discover/details_container_content.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late bool isClipped;

  @override
  void initState() {
    isClipped = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: CachedNetworkImage(
              imageUrl: widget.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.47,
            minChildSize: 0.47,
            builder: (context, scrollController) {
              return NotificationListener<DraggableScrollableNotification>(
                onNotification: (notification) {
                  final newIsClipped = notification.extent < 0.65;
                  if (newIsClipped != isClipped) {
                    setState(() {
                      isClipped = newIsClipped;
                    });
                  }
                  return true;
                },
                child: DetailsClippedContainer(
                  isClipped: isClipped,
                  child: DetailsContainerContent(controller: scrollController),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
