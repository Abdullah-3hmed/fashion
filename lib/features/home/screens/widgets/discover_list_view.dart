import 'package:e_fashion_flutter/features/home/screens/widgets/discover_item.dart';
import 'package:flutter/material.dart';

class DiscoverListView extends StatelessWidget {
  const DiscoverListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      key: const ValueKey('list'),
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => const DiscoverItem(),
      separatorBuilder: (_, __) => const SizedBox(height: 16.0),
      itemCount: 10,
    );
  }
}
