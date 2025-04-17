import 'package:e_fashion_flutter/features/search/screens/widgets/search_modal_bottom_sheet_content.dart';
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
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadiusDirectional.only(
                          topStart: Radius.circular(32.0),
                          topEnd: Radius.circular(32.0),
                        ),
                      ),
                      builder:
                          (context) => const SearchModalBottomSheetContent(),
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
