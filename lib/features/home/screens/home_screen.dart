import 'package:auto_route/auto_route.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/category/category_section.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/home_header/home_header_bloc_builder.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/offers/offers_section.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/products/products_section.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
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
      ),
    );
  }
}
