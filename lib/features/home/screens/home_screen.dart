import 'package:auto_route/auto_route.dart';
import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/core/services/service_locator.dart';
import 'package:e_fashion_flutter/core/utils/app_constants.dart';
import 'package:e_fashion_flutter/core/widgets/no_internet_widget.dart';
import 'package:e_fashion_flutter/features/favourite/cubit/favorite_cubit.dart';
import 'package:e_fashion_flutter/features/home/cubit/home_cubit.dart';
import 'package:e_fashion_flutter/features/home/cubit/home_state.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/category/category_section.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/home_header/home_header_bloc_builder.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/offers/offers_section.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/products/brand_section.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/products/brand_section_item.dart';
import 'package:e_fashion_flutter/shared/data/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

@RoutePage()
class HomeScreen extends StatelessWidget implements AutoRouteWrapper {
  const HomeScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeCubit>()..getAllHomeData(),
      child: this,
    );
  }

  static const ProductModel dummyProductModel = ProductModel(
    imageUrl: AppConstants.imageUrl,
    basePrice: 0.0,
    colors: "",
    discountPrice: 0.0,
    isOffer: false,
    sizes: "",
    id: "",
    title: "",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocSelector<HomeCubit, HomeState, bool>(
        selector: (state) => state.isConnected,
        builder: (context, isConnected) {
          return isConnected
              ? CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  const SliverToBoxAdapter(child: HomeHeaderBlocBuilder()),
                  const SliverToBoxAdapter(child: CategorySection()),
                  const SliverToBoxAdapter(child: OffersSection()),
                  ..._buildProductsSections(context),
                  const SliverToBoxAdapter(child: SizedBox(height: 100.0)),
                ],
              )
              : NoInternetWidget(
                errorMessage: context.select(
                  (HomeCubit cubit) => cubit.state.collectionsErrorMessage,
                ),
                onPressed: () async {
                  await context.read<HomeCubit>().getAllHomeData();
                 if(context.mounted) {
                   await context.read<FavoriteCubit>().getFavorites();
                 }

                },
              );
        },
      ),
    );
  }

  List<Widget> _buildProductsSections(BuildContext context) {
    final state = context.watch<HomeCubit>().state;

    switch (state.productsState) {
      case RequestStatus.loading:
        return [
          const SliverToBoxAdapter(child: SizedBox(height: 20.0)),
          SliverToBoxAdapter(
            child: Skeletonizer(
              child: SizedBox(
                height: 180.0,
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder:
                      (context, index) => const SizedBox(
                        width: 240.0,
                        child: BrandSectionItem(
                          productModel: dummyProductModel,
                        ),
                      ),
                  separatorBuilder:
                      (context, index) => const SizedBox(width: 12.0),
                ),
              ),
            ),
          ),
        ];

      case RequestStatus.success:
        return state.products.groupedBrandProducts.entries
            .where((entry) => entry.value.isNotEmpty)
            .map(
              (entry) => SliverToBoxAdapter(
                child: BrandSection(
                  brandName: entry.key,
                  products: entry.value,
                ),
              ),
            )
            .toList();

      case RequestStatus.error:
        return [
          SliverToBoxAdapter(
            child: Center(
              child: Text(
                state.productsErrorMessage,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
        ];

      default:
        return [const SliverToBoxAdapter(child: SizedBox.shrink())];
    }
  }
}
