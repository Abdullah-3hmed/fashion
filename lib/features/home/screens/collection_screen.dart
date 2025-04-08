import 'package:auto_route/auto_route.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/collection_item.dart';
import 'package:flutter/material.dart';

@RoutePage()
class CollectionScreen extends StatelessWidget {
  const CollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Summer Collection",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemCount: 6,
          separatorBuilder: (context, index) => const SizedBox(height: 16.0),
          itemBuilder: (context, index) => CollectionItem(index: index),
        ),
      ),
    );
  }
}
