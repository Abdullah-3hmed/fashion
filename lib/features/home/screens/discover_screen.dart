import 'package:auto_route/annotations.dart';
import 'package:e_fashion_flutter/core/widgets/discover_and_search_grid_view.dart';
import 'package:e_fashion_flutter/features/home/cubit/home_cubit.dart';
import 'package:e_fashion_flutter/features/home/cubit/home_state.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/discover/discover_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solar_icons/solar_icons.dart';

@RoutePage()
class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key, this.isOffer = false});

  final bool isOffer;

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  bool isGrid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Discover", style: Theme.of(context).textTheme.titleMedium),
        actions: [
          IconButton(
            onPressed: () {
              if (isGrid) {
                setState(() {
                  isGrid = false;
                });
              }
            },
            icon: const Icon(SolarIconsOutline.stop),
          ),
          IconButton(
            onPressed: () {
              if (!isGrid) {
                setState(() {
                  isGrid = true;
                });
              }
            },
            icon: const Icon(SolarIconsOutline.pause),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: BlocBuilder<HomeCubit, HomeState>(
          buildWhen:
              (previous, current) =>
                  previous.productsDiscoverList !=
                      current.productsDiscoverList ||
                  previous.offersDiscoverList != current.offersDiscoverList,
          builder: (context, state) {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              transitionBuilder: (child, animation) {
                final offsetAnimation = Tween<Offset>(
                  begin: const Offset(1.0, 0.0), // Slide from right
                  end: Offset.zero,
                ).animate(animation);
                return SlideTransition(position: offsetAnimation, child: child);
              },
              child:
                  isGrid
                      ? DiscoverAndSearchGridView(
                        discoverList:
                            widget.isOffer
                                ? state.offersDiscoverList
                                : state.productsDiscoverList,
                      )
                      : DiscoverListView(
                        discoverList:
                            widget.isOffer
                                ? state.offersDiscoverList
                                : state.productsDiscoverList,
                      ),
            );
          },
        ),
      ),
    );
  }
}
