import 'package:flutter/material.dart';

class FilterSectionItem extends StatefulWidget {
  const FilterSectionItem({super.key, required this.image, required this.text});

  final String image;
  final String text;

  @override
  State<FilterSectionItem> createState() => _FilterSectionItemState();
}

class _FilterSectionItemState extends State<FilterSectionItem> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
        });
      },
      child: Column(
        children: [
          _isSelected
              ? CircleAvatar(
                radius: 22.0,
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: CircleAvatar(
                  radius: 20.0,
                  backgroundImage: Image(image: AssetImage(widget.image)).image,
                ),
              )
              : CircleAvatar(
                radius: 20.0,
                backgroundImage: Image(image: AssetImage(widget.image)).image,
              ),
          const SizedBox(height: 8.0),
          Text(widget.text, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}
