import 'package:auto_route/auto_route.dart';
import 'package:e_fashion_flutter/features/search/screens/widgets/result_search_section.dart';
import 'package:e_fashion_flutter/features/search/screens/widgets/search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:solar_icons/solar_icons.dart';

@RoutePage()
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isGrid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search", style: Theme.of(context).textTheme.titleMedium),
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
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: 24.0,
          vertical: 16.0,
        ),
        child: Column(
          children: [
            const SearchTextField(),
            const SizedBox(height: 16.0),
            Expanded(child: ResultSearchSection(isGrid: isGrid)),
            // Expanded(child: NoResultSearchSection()),
          ],
        ),
      ),
    );
  }
}
