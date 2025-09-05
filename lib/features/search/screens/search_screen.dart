import 'package:auto_route/auto_route.dart';
import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/core/services/service_locator.dart';
import 'package:e_fashion_flutter/core/utils/app_constants.dart';
import 'package:e_fashion_flutter/features/search/bloc/search_bloc.dart';
import 'package:e_fashion_flutter/features/search/bloc/search_state.dart';
import 'package:e_fashion_flutter/features/search/screens/widgets/empty_search.dart';
import 'package:e_fashion_flutter/features/search/screens/widgets/no_result_search_section.dart';
import 'package:e_fashion_flutter/features/search/screens/widgets/result_search_section.dart';
import 'package:e_fashion_flutter/features/search/screens/widgets/search_text_field.dart';
import 'package:e_fashion_flutter/shared/data/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:solar_icons/solar_icons.dart';

@RoutePage()
class SearchScreen extends StatefulWidget implements AutoRouteWrapper {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(create: (context) => getIt<SearchBloc>(), child: this);
  }
}

class _SearchScreenState extends State<SearchScreen> {
  bool isGrid = false;
  List<ProductModel> dummyList = List<ProductModel>.generate(
    5,
    (index) => const ProductModel(
      colors: "",
      sizes: "",
      isOffer: false,
      title: "*************",
      id: "****",
      discountPrice: 0.0,
      basePrice: 0.0,
      imageUrl: AppConstants.imageUrl,
    ),
  );

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
            BlocBuilder<SearchBloc, SearchState>(
              buildWhen:
                  (previous, current) =>
                      previous.searchStatus != current.searchStatus,
              builder: (context, state) {
                switch (state.searchStatus) {
                  case RequestStatus.initial:
                    return const Expanded(child: NoResultSearchSection());
                  case RequestStatus.loading:
                    return Expanded(
                      child: Skeletonizer(
                        child: ResultSearchSection(
                          isGrid: isGrid,
                          searchProducts: dummyList,
                        ),
                      ),
                    );
                  case RequestStatus.success:
                    return state.searchProducts.isEmpty
                        ? const Expanded(child: EmptySearch())
                        : Expanded(
                          child: ResultSearchSection(
                            isGrid: isGrid,
                            searchProducts: state.searchProducts,
                          ),
                        );
                  case RequestStatus.error:
                    return Expanded(
                      child: Center(
                        child: Text(
                          state.searchErrorMessage,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
