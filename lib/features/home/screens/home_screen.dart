import 'package:auto_route/auto_route.dart';
import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/core/services/service_locator.dart';
import 'package:e_fashion_flutter/core/widgets/no_internet_widget.dart';
import 'package:e_fashion_flutter/features/home/cubit/home_cubit.dart';
import 'package:e_fashion_flutter/features/home/cubit/home_state.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/category/category_section.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/home_header/home_header_bloc_builder.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/offers/offers_section.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/products/products_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class HomeScreen extends StatelessWidget implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeCubit>()..getCollections(),
      child: this,
    );
  }

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocSelector<HomeCubit, HomeState, bool>(
        selector: (state) => state.isConnected,
        builder: (BuildContext context, isConnected) {
          return isConnected
              ? const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HomeHeaderBlocBuilder(),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0),
                      child: CustomScrollView(
                        physics: BouncingScrollPhysics(),
                        slivers: [
                          SliverToBoxAdapter(child: CategorySection()),
                          SliverToBoxAdapter(child: OffersSection()),
                          SliverToBoxAdapter(
                            child: ProductsSection(brandName: "Products"),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 90.0),
                ],
              )
              : NoInternetWidget(
                isLoading: context.select(
                  (HomeCubit cubit) => cubit.state.collectionsStatus.isLoading,
                ),
                onPressed: () async {
                  await context.read<HomeCubit>().getAllHomeData();
                },
              );
        },
      ),
    );
  }
}
