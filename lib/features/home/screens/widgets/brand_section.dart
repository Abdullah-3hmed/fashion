import 'package:flutter/material.dart';

class BrandSection extends StatelessWidget {
  const BrandSection({super.key, required this.brandName});

  final String brandName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(brandName, style: Theme.of(context).textTheme.bodyMedium),
            TextButton(
              style: ButtonStyle(
                padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.zero,
                ),
              ),
              onPressed: () {},
              child: Text(
                "See All",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        SizedBox(
          height: 180.0,
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            itemBuilder: (context, index) => const SizedBox.shrink(),
            // const SizedBox(width: 180.0, child: BrandSectionItem()),
            separatorBuilder:
                (BuildContext context, int index) =>
                    const SizedBox(width: 12.0),
          ),
        ),
      ],
    );
  }
}
