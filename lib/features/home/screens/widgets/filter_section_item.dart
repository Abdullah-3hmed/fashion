import 'package:flutter/material.dart';

class FilterSectionItem extends StatelessWidget {
  const FilterSectionItem({
    super.key,
    required this.image,
    required this.text,
    this.isSelected = false,
  });

  final String image;
  final String text;
  final bool isSelected;

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
                backgroundImage: Image(image: AssetImage(image)).image,
              ),
            )
            : CircleAvatar(
              radius: 20.0,
              backgroundImage: Image(image: AssetImage(image)).image,
            ),
        const SizedBox(height: 8.0),
        Text(text, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
