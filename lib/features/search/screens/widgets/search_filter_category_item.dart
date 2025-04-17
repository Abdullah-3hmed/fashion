import 'package:flutter/material.dart';

class SearchFilterCategoryItem extends StatelessWidget {
  final String brandName;
  final bool isSelected;

  const SearchFilterCategoryItem({
    super.key,
    required this.brandName,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        color:
            isSelected
                ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.1)
                : Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(
          width: 1.5,
          color:
              isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.outline,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color:
                    isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey,
                width: 2.0,
              ),
              color:
                  isSelected
                      ? Theme.of(context).colorScheme.primary
                      : Colors.transparent,
            ),
            child:
                isSelected
                    ? const Icon(Icons.check, size: 14.0, color: Colors.white)
                    : null,
          ),
          const SizedBox(width: 8.0),
          Text(brandName, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
