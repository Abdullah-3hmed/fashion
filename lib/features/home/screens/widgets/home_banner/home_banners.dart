import 'package:auto_route/auto_route.dart';
import 'package:e_fashion_flutter/config/router/app_router.dart';
import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/features/home/cubit/home_cubit/home_cubit.dart';
import 'package:e_fashion_flutter/features/home/cubit/home_cubit/home_state.dart';
import 'package:e_fashion_flutter/features/home/data/home/collection_model.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/collection/collections_page_view_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CollectionSection extends StatelessWidget {
  const CollectionSection({super.key});

  static final dummyCollections = List<CollectionModel>.generate(
    5,
    (index) => const CollectionModel(
      id: "",
      title: '•••••• ••••••',
      imageUrl: "",
      description: '••% OFF',
      subTitle: '•••••••••••••',
    ),
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen:
          (previous, current) =>
              previous.collectionsStatus != current.collectionsStatus,
      builder: (context, state) {
        switch (state.collectionsStatus) {
          case RequestStatus.loading:
            return Skeletonizer(
              child: HomeBanners(collections: dummyCollections),
            );
          case RequestStatus.success:
            return HomeBanners(collections: state.collections);
          case RequestStatus.error:
            return SizedBox(
              height: 200.0,
              child: Text(
                state.collectionsErrorMessage,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            );
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}

class HomeBanners extends StatefulWidget {
  const HomeBanners({super.key, this.collections = const []});

  final List<CollectionModel> collections;

  @override
  State<HomeBanners> createState() => _HomeBannersState();
}

class _HomeBannersState extends State<HomeBanners> {
  late final PageController controller;

  @override
  void initState() {
    controller = PageController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final collections = widget.collections;
    return SizedBox(
      height: 320,
      width: double.infinity,
      child: Stack(
        children: [
          PageView.builder(
            controller: controller,
            itemCount: collections.length,
            itemBuilder:
                (context, index) =>
                    CollectionsPageViewItem(collection: collections[index]),
          ),
          PositionedDirectional(
            bottom: 24.0,
            start: 24.0,
            child: SmoothPageIndicator(
              controller: controller,
              count: collections.length,
              effect: const ExpandingDotsEffect(
                dotWidth: 30.0,
                dotHeight: 4.0,
                activeDotColor: Colors.white,
                dotColor: Colors.white60,
                expansionFactor: 1.25,
              ),
              onDotClicked: (index) {
                controller.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeInOut,
                );
              },
            ),
          ),
          PositionedDirectional(
            top: 54.0,
            start: 24.0,
            end: 24.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    context.pushRoute(const SearchRoute());
                  },
                  icon: const Icon(
                    Iconsax.search_normal_1,
                    color: Colors.white,
                    size: 24.0,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    context.pushRoute(const NotificationRoute());
                  },
                  icon: const Icon(Iconsax.notification, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
