import 'package:auto_route/annotations.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/discover/discover_grid_view.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/discover/discover_list_view.dart';
import 'package:e_fashion_flutter/shared/data/product_model.dart';
import 'package:flutter/material.dart';
import 'package:solar_icons/solar_icons.dart';

@RoutePage()
class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key, required this.productsDiscoverList,});

  final List<ProductModel> productsDiscoverList;
  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final ValueNotifier<bool> isGrid = ValueNotifier<bool>(false);

  @override
  void dispose() {
    isGrid.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Discover", style: Theme.of(context).textTheme.titleMedium),
        actions: [
          IconButton(
            onPressed: () {
              isGrid.value = false;
            },
            icon: const Icon(SolarIconsOutline.stop),
          ),
          IconButton(
            onPressed: () {
              isGrid.value = true;
            },
            icon: const Icon(SolarIconsOutline.pause),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: ValueListenableBuilder<bool>(
          valueListenable: isGrid,
          builder: (context, value, _) {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              transitionBuilder: (child, animation) {
                final offsetAnimation = Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(animation);
                return SlideTransition(position: offsetAnimation, child: child);
              },
              child: value
                  ? DiscoverGridView(
                key: const ValueKey('grid'),
                discoverList: widget.productsDiscoverList,
              )
                  : DiscoverListView(
                key: const ValueKey('list'),
                discoverList: widget.productsDiscoverList,
              ),
            );
          },
        ),
      ),
    );
  }
}
