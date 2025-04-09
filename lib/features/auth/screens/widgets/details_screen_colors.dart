import 'package:flutter/material.dart';

class ColorModel {
  final Color color;
  bool isSelected;

  ColorModel({required this.color, this.isSelected = false});
}

class DetailsScreenColors extends StatefulWidget {
  const DetailsScreenColors({super.key});

  @override
  State<DetailsScreenColors> createState() => _DetailsScreenColorsState();
}

class _DetailsScreenColorsState extends State<DetailsScreenColors> {
  List<ColorModel> colors = [
    ColorModel(color: const Color(0xFF4AA8FF)),
    ColorModel(color: Colors.white),
    ColorModel(color: const Color(0xFFFFA6A6)),
    ColorModel(color: const Color(0xFF497833)),
    ColorModel(color: Colors.black),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 37.0,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: colors.length,
        itemBuilder:
            (context, index) => CircleAvatar(
              radius: colors[index].isSelected ? 14.0 : 12.0,
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: InkWell(
                onTap: () {
                  setState(() {
                    colors[index].isSelected = !colors[index].isSelected;
                  });
                },
                child: CircleAvatar(
                  radius: 12.0,
                  backgroundColor: colors[index].color,
                ),
              ),
            ),
        separatorBuilder:
            (BuildContext context, int index) => const SizedBox(width: 18.0),
      ),
    );
  }
}
