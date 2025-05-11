import 'package:e_fashion_flutter/core/widgets/third_button.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/filter_category_section.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/filter_gender_section.dart';
import 'package:flutter/material.dart';

class FilterSection extends StatefulWidget {
  const FilterSection({super.key});

  @override
  State<FilterSection> createState() => _FilterSectionState();
}

class _FilterSectionState extends State<FilterSection> {
  final ValueNotifier<double> genderWidth = ValueNotifier<double>(145);

  @override
  void dispose() {
    genderWidth.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Filter", style: Theme.of(context).textTheme.bodyMedium),
            ThirdButton(onPressed: () {}, text: "Apply"),
          ],
        ),
        const SizedBox(height: 8.0),
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ValueListenableBuilder<double>(
                valueListenable: genderWidth,
                builder: (context, value, _) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: value,
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 16.0,
                    ),
                    decoration: BoxDecoration(
                      color:
                          Theme.of(context).colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: ClipRect(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        widthFactor: value / 145.0,
                        child: FilterGenderSection(
                          onGenderChanged: (value) {
                            debugPrint(value);
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(width: 16.0),
              GestureDetector(
                onHorizontalDragUpdate: (details) {
                  genderWidth.value = (genderWidth.value + details.delta.dx)
                      .clamp(0.0, 145.0);
                },
                child: Stack(
                  alignment: AlignmentDirectional.centerStart,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 16.0,
                      ),
                      decoration: BoxDecoration(
                        color:
                            Theme.of(
                              context,
                            ).colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: FilterCategorySection(
                        onCategoryChanged: (String value) {
                          debugPrint(value);
                        },
                      ),
                    ),
                    Container(
                      height: 40.0,
                      width: 5.0,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(5.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
