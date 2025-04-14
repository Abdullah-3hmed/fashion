import 'package:flutter/material.dart';

class ColorsAvailable extends StatefulWidget {
  const ColorsAvailable({super.key, required this.onColorChanged});
  final ValueChanged<int> onColorChanged;
  @override
  State<ColorsAvailable> createState() => _ColorsAvailableState();
}

class _ColorsAvailableState extends State<ColorsAvailable> {
  int selectedColor = 0;
  List<Color> colors = [
    const Color(0xFF4AA8FF),
    Colors.white,
    const Color(0xFFFFA6A6),
    const Color(0xFF497833),
    Colors.black,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 37.0,
      child: Row(
        children: [
          Text("Color : ", style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(width: 18.0),
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: colors.length,
              itemBuilder:
                  (context, index) => CircleAvatar(
                    radius: selectedColor == index ? 14.0 : 12.0,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selectedColor = index;
                          widget.onColorChanged(index);
                        });
                      },
                      child: CircleAvatar(
                        radius: 12.0,
                        backgroundColor: colors[index],
                      ),
                    ),
                  ),
              separatorBuilder:
                  (BuildContext context, int index) =>
                      const SizedBox(width: 18.0),
            ),
          ),
        ],
      ),
    );
  }
}
