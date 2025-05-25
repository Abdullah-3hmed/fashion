import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_fashion_flutter/config/router/app_router.dart';
import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/core/utils/app_constants.dart';
import 'package:e_fashion_flutter/features/home/cubit/home_cubit.dart';
import 'package:e_fashion_flutter/features/home/cubit/home_state.dart';
import 'package:e_fashion_flutter/features/home/data/offer_model.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/shared/home_carousel_slider_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class OffersSection extends StatelessWidget {
  const OffersSection({super.key});

  static List<OfferModel> dummyOffers = List<OfferModel>.generate(
    5,
    (index) => const OfferModel(
      id: 1,
      name: "dummy name",
      imageUrl: AppConstants.imageUrl,
      oldPrice: 300.0,
      discountedPrice: 300.0,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Offers", style: Theme.of(context).textTheme.bodyMedium),
            TextButton(
              style: ButtonStyle(
                padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.zero,
                ),
              ),
              onPressed: () {
                context.pushRoute(DiscoverRoute(isOffer: true));
              },
              child: Text(
                "Discover",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
        BlocBuilder<HomeCubit, HomeState>(
          buildWhen:
              (previous, current) =>
                  previous.offersStatus != current.offersStatus,
          builder: (context, state) {
            switch (state.offersStatus) {
              case RequestStatus.loading:
                return Skeletonizer(
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
                      initialPage: 2,
                      viewportFraction: 0.70,
                      enableInfiniteScroll: false,
                    ),
                  ),
                );
              case RequestStatus.success:
                return CarouselSlider(
                  items:
                      state.offers
                          .map(
                            (offer) =>
                                HomeCarouselSliderItem(offerModel: offer),
                          )
                          .toList(),
                  options: CarouselOptions(
                    enlargeCenterPage: true,
                    initialPage: 2,
                    viewportFraction: 0.70,
                    enableInfiniteScroll: false,
                  ),
                );
              case RequestStatus.error:
                return SizedBox(
                  height: 180.0,
                  child: Text(state.offersErrorMessage),
                );
              default:
                return const SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }
}
