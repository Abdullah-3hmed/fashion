import 'package:e_fashion_flutter/features/search/screens/widgets/search_list/search_list_view.dart';
import 'package:flutter/material.dart';

class ResultSearchSection extends StatelessWidget {
  const ResultSearchSection({super.key, required this.isGrid});
  final bool isGrid;
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      transitionBuilder: (child, animation) {
        final offsetAnimation = Tween<Offset>(
          begin: const Offset(1.0, 0.0), // Slide from right
          end: Offset.zero,
        ).animate(animation);
        return SlideTransition(position: offsetAnimation, child: child);
      },
      child: const SearchListView(),
    );
  }
}
