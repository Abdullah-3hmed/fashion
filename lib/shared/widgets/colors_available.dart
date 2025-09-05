import 'package:e_fashion_flutter/core/utils/color_map.dart';
import 'package:flutter/material.dart';

class ColorsAvailable extends StatefulWidget {
  const ColorsAvailable({
    super.key,
    required this.onColorChanged,
    required this.colors,
  });

  final ValueChanged<String> onColorChanged;
  final List<String> colors;

  @override
  State<ColorsAvailable> createState() => _ColorsAvailableState();
}

class _ColorsAvailableState extends State<ColorsAvailable> {
  final ValueNotifier<int> selectedColor = ValueNotifier<int>(0);

  @override
  void dispose() {
    selectedColor.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 37.0,
      child: Row(
        children: [
          Text("Color : ", style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(width: 18.0),
          Expanded(
            child: ValueListenableBuilder<int>(
              valueListenable: selectedColor,
              builder: (context, value, _) {
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.colors.length,
                  itemBuilder:
                      (context, index) => CircleAvatar(
                        radius: value == index ? 14.0 : 12.0,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: InkWell(
                          onTap: () {
                            selectedColor.value = index;
                            widget.onColorChanged(widget.colors[index]);
                          },
                          child: CircleAvatar(
                            radius: 12.0,
                            backgroundColor: Color(
                              colorHexMap[widget.colors[index]]!,
                            ),
                          ),
                        ),
                      ),
                  separatorBuilder:
                      (BuildContext context, int index) =>
                          const SizedBox(width: 18.0),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
