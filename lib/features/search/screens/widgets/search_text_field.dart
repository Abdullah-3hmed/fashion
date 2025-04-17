import 'package:e_fashion_flutter/features/search/screens/widgets/search_filter_brand_items.dart';
import 'package:e_fashion_flutter/features/search/screens/widgets/search_filter_category_items.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SearchTextField extends StatefulWidget {
  const SearchTextField({super.key});

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  String searchText = "";
  bool isTapped = false;
  late final TextEditingController controller;

  @override
  void initState() {
    isTapped = false;
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: (_) {
        setState(() {
          isTapped = false;
        });
      },
      onChanged: (value) {
        searchText = value;
      },
      onTap: () {
        setState(() {
          isTapped = true;
        });
      },
      controller: controller,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      decoration: InputDecoration(
        prefixIcon: const Icon(Iconsax.search_normal_1),
        suffixIcon:
            isTapped
                ? IconButton(
                  onPressed: () {
                    controller.clear();
                  },
                  icon: const Icon(Icons.close),
                )
                : IconButton(
                  onPressed: () async {
                    await showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadiusDirectional.only(
                          topStart: Radius.circular(24.0),
                          topEnd: Radius.circular(24.0),
                        ),
                      ),
                      builder:
                          (context) => Padding(
                            padding: const EdgeInsetsDirectional.symmetric(
                              horizontal: 24.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20.0),
                                Divider(
                                  thickness: 4.0,
                                  height: 20.0,
                                  indent: 155.0,
                                  endIndent: 155.0,
                                  color: Theme.of(context).colorScheme.outline,
                                ),
                                const SizedBox(height: 20.0),
                                Align(
                                  child: Text(
                                    "Search Filters",
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ),
                                const SizedBox(height: 30.0),
                                Text(
                                  "Brands",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                const Divider(
                                  thickness: 1.0,
                                  color: Color(0x1a1c1e40),
                                ),
                                const SizedBox(height: 8.0),
                                const Flexible(child: SearchFilterBrandItems()),
                                const SizedBox(height: 24.0),
                                Text(
                                  "Categories",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                const Divider(
                                  thickness: 1.0,
                                  color: Color(0x1a1c1e40),
                                ),
                                const SizedBox(height: 8.0),
                                const Flexible(
                                  child: SearchFilterCategoryItems(),
                                ),
                              ],
                            ),
                          ),
                    );
                  },
                  icon: const Icon(Iconsax.filter_search),
                ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        hintText: "search",
        hintStyle: Theme.of(context).textTheme.bodySmall,
        filled: true,
        fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      ),
    );
  }
}
