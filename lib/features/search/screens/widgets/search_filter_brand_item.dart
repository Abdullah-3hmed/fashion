import 'package:flutter/material.dart';

class SearchFilterBrandItem extends StatelessWidget {
  const SearchFilterBrandItem({
    super.key,
    this.isSelected = false,
    required this.brandName,
  });
  final bool isSelected;
  final String brandName;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: 12.0,
        vertical: 6.0,
      ),
      decoration: BoxDecoration(
        color:
            isSelected
                ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.1)
                : Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadiusDirectional.circular(32.0),
        border: Border.all(
          width: 1.5,
          color:
              isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.outline,
        ),
      ),
      child: Text(
        brandName,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.labelLarge,
      ),
    );
  }
}
