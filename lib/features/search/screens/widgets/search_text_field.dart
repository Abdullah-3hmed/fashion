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
                  onPressed: () {},
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
