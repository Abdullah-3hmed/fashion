import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FilterSectionItem extends StatelessWidget {
  const FilterSectionItem({
    super.key,
    this.image = "",
    required this.text,
    this.imageUrl = "",
    this.isSelected = false,
    this.isCategory = false,
  });

  final String image;
  final String imageUrl;
  final String text;
  final bool isSelected;
  final bool isCategory;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        isSelected
            ? CircleAvatar(
              radius: 22.0,
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: CircleAvatar(
                radius: 20.0,
                backgroundColor: Colors.transparent,
                backgroundImage:
                    isCategory
                        ? CachedNetworkImageProvider(image)
                        : Image(image: AssetImage(image)).image,
              ),
            )
            : CircleAvatar(
              radius: 20.0,
              backgroundColor: Colors.transparent,
              backgroundImage:
                  isCategory
                      ? CachedNetworkImageProvider(image)
                      : Image(image: AssetImage(image)).image,
            ),
        const SizedBox(height: 8.0),
        Text(text, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
