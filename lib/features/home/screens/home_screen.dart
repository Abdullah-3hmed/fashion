import 'package:auto_route/auto_route.dart';
import 'package:e_fashion_flutter/core/services/service_locator.dart';
import 'package:e_fashion_flutter/core/utils/app_constants.dart';
import 'package:e_fashion_flutter/core/widgets/no_internet_widget.dart';
import 'package:e_fashion_flutter/features/cart/cubit/cart_cubit.dart';
import 'package:e_fashion_flutter/features/favourite/cubit/favorite_cubit.dart';
import 'package:e_fashion_flutter/features/home/cubit/home_cubit.dart';
import 'package:e_fashion_flutter/features/home/cubit/home_state.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/category/category_section.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/home_header/home_header_bloc_builder.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/offers/offers_section.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/products/products_section.dart';
import 'package:e_fashion_flutter/features/profile/cubit/chat_cubit/chat_cubit.dart';
import 'package:e_fashion_flutter/features/profile/cubit/user_cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class HomeScreen extends StatefulWidget implements AutoRouteWrapper {
  const HomeScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeCubit>()..getAllHomeData(),
      child: this,
    );
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CartCubit>().getCartItems();
      context.read<FavoriteCubit>().getFavorites();
      context.read<UserCubit>().getUserProfile();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocSelector<HomeCubit, HomeState, bool>(
        selector: (state) => state.isConnected,
        builder: (context, isConnected) {
          return isConnected
              ? const CustomScrollView(
                physics: BouncingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(child: HomeHeaderBlocBuilder()),
                  SliverToBoxAdapter(child: CategorySection()),
                  SliverToBoxAdapter(child: OffersSection()),
                  ProductsSection(),
                  SliverToBoxAdapter(child: SizedBox(height: 100.0)),
                ],
              )
              : NoInternetWidget(
                errorMessage: context.select(
                  (HomeCubit cubit) => cubit.state.collectionsErrorMessage,
                ),
                onPressed: () async {
                  await _getAllAppData(context);

                },
              );
        },
      ),
    );
  }

  Future<void> _getAllAppData(BuildContext context) async {
    if (!mounted) return;

    final homeCubit = context.read<HomeCubit>();
    final favoriteCubit = context.read<FavoriteCubit>();
    final cartCubit = context.read<CartCubit>();
    final userCubit = context.read<UserCubit>();

    await homeCubit.getAllHomeData();
    await favoriteCubit.getFavorites();
    await cartCubit.getCartItems();
    await userCubit.getUserProfile();
  }

}
