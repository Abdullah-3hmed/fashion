import 'package:flutter/material.dart';

class SizesAvailable extends StatefulWidget {
  const SizesAvailable({super.key, required this.onColorChanged, required this.sizes});
  final ValueChanged<String> onColorChanged;
  final List<String> sizes;
  @override
  State<SizesAvailable> createState() => _SizesAvailableState();
}

class _SizesAvailableState extends State<SizesAvailable> {
  int selectedSize = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 37.0,
      child: Row(
        children: [
          Text("Size : ", style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(width: 18.0),
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: widget.sizes.length,
              itemBuilder:
                  (context, index) => InkWell(
                    onTap: () {
                      selectedSize = index;
                      widget.onColorChanged(widget.sizes[index]);
                      setState(() {});
                    },
                    child: CircleAvatar(
                      radius: 14.0,
                      backgroundColor:
                          selectedSize == index
                              ? Theme.of(context).colorScheme.primary
                              : Colors.transparent,
                      child: Text(
                        widget.sizes[index],
                        style:
                            selectedSize == index
                                ? Theme.of(
                                  context,
                                ).textTheme.bodySmall!.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                )
                                : Theme.of(context).textTheme.bodySmall,
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
