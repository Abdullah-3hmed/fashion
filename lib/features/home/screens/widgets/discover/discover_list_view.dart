import 'package:e_fashion_flutter/features/home/data/discover_model.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/discover/discover_list_tem.dart';
import 'package:flutter/material.dart';

class DiscoverListView extends StatelessWidget {
  const DiscoverListView({super.key, required this.discoverList});

  final List<DiscoverModel> discoverList;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      key: const ValueKey('list'),
      physics: const BouncingScrollPhysics(),
      itemBuilder:
          (context, index) => DiscoverListItem(
            isFirstItem: index == 0,
            discoverModel: discoverList[index],
          ),
      separatorBuilder: (_, __) => const SizedBox(height: 16.0),
      itemCount: discoverList.length,
    );
  }
}
