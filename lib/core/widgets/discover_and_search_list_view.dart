import 'package:e_fashion_flutter/core/widgets/discover_and_search_item.dart';
import 'package:flutter/material.dart';

class DiscoverAndSearchListView extends StatelessWidget {
  const DiscoverAndSearchListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      key: const ValueKey('list'),
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => const DiscoverAndSearchItem(),
      separatorBuilder: (_, __) => const SizedBox(height: 16.0),
      itemCount: 10,
    );
  }
}
