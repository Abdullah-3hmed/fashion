import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_fashion_flutter/config/router/app_router.dart';
import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/core/utils/app_constants.dart';
import 'package:e_fashion_flutter/features/home/cubit/home_cubit/home_cubit.dart';
import 'package:e_fashion_flutter/features/home/cubit/home_cubit/home_state.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/offers/home_carousel_slider_item.dart';
import 'package:e_fashion_flutter/shared/data/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class OffersSection extends StatelessWidget {
  const OffersSection({super.key});

  static List<ProductModel> dummyOffers = List<ProductModel>.generate(
    3,
    (index) => const ProductModel(
      title: "*********",
      imageUrl: AppConstants.imageUrl,
      id: "",
      basePrice: 0.0,
      colors: "",
      discountPrice: 0.0,
      sizes: "",
      isOffer: true,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen:
          (previous, current) => previous.offersState != current.offersState,
      builder: (context, state) {
        switch (state.offersState) {
          case RequestStatus.loading:
            return Column(
              children: [
                const SizedBox(height: 20.0),
                Skeletonizer(
                  child: CarouselSlider(
                    items:
                        dummyOffers
                            .map(
                              (offer) =>
                                  HomeCarouselSliderItem(offerModel: offer),
                            )
                            .toList(),
                    options: CarouselOptions(
                      enlargeCenterPage: true,
                      initialPage: 1,
                      viewportFraction: 0.70,
                      enableInfiniteScroll: false,
                    ),
                  ),
                ),
              ],
            );
          case RequestStatus.success:
            return state.offersModel.offers.isEmpty
                ? const SizedBox.shrink()
                : Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Offers",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        TextButton(
                          style: ButtonStyle(
                            padding:
                                WidgetStateProperty.all<EdgeInsetsGeometry>(
                                  EdgeInsets.zero,
                                ),
                          ),
                          onPressed: () {
                            context.pushRoute(
                              DiscoverRoute(
                                isOffer: true,
                                homeCubit: context.read<HomeCubit>(),
                              ),
                            );
                          },
                          child: Text(
                            "Discover",
                            style: Theme.of(
                              context,
                            ).textTheme.labelMedium!.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    CarouselSlider(
                      items:
                          state.offersModel.offers
                              .map(
                                (offer) =>
                                    HomeCarouselSliderItem(offerModel: offer),
                              )
                              .toList(),
                      options: CarouselOptions(
                        enlargeCenterPage: true,
                        initialPage: state.offersModel.offers.length ~/ 2,
                        viewportFraction: 0.70,
                        enableInfiniteScroll: false,
                      ),
                    ),
                  ],
                );
          case RequestStatus.error:
            return SizedBox(
              height: 180.0,
              child: Text(state.productsErrorMessage),
            );
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}
