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
    final imageProvider =
        isCategory
            ? CachedNetworkImageProvider(image)
            : AssetImage(image) as ImageProvider;

    return Column(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border:
                isSelected
                    ? Border.all(
                      color: Theme.of(context).colorScheme.primary,
                      width: 3,
                    )
                    : null,
          ),
          child: CircleAvatar(
            radius: 20.0,
            backgroundColor: Colors.transparent,
            backgroundImage: imageProvider,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(text, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
