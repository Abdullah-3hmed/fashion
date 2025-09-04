import 'package:auto_route/annotations.dart';
import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/features/home/cubit/home_cubit/home_cubit.dart';
import 'package:e_fashion_flutter/features/home/cubit/home_cubit/home_state.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/discover/discover_grid_view.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/discover/discover_list_view.dart';
import 'package:e_fashion_flutter/shared/data/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solar_icons/solar_icons.dart';

@RoutePage()
class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({
    super.key,
    this.isOffer = false,
    this.brand = "",
    required this.homeCubit,
  });

  final bool isOffer;
  final HomeCubit homeCubit;
  final String brand;

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final ValueNotifier<bool> isGrid = ValueNotifier<bool>(false);
  late final ScrollController _scrollController;
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  void _onScroll() {
    if (_isLoadingMore || !_scrollController.hasClients) return;
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _isLoadingMore = true;
      if (widget.isOffer) {
        widget.homeCubit.loadMoreOffers();
      } else {
        widget.homeCubit.loadMoreProducts();
      }
    }
  }

  void _resetLoading(RequestStatus status) {
    if (_isLoadingMore && (status.isSuccess || status.isError)) {
      _isLoadingMore = false;
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    isGrid.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Discover ${widget.brand}", style: Theme.of(context).textTheme.titleMedium),
        actions: [
          IconButton(
            onPressed: () => isGrid.value = false,
            icon: const Icon(SolarIconsOutline.stop),
          ),
          IconButton(
            onPressed: () => isGrid.value = true,
            icon: const Icon(SolarIconsOutline.pause),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: ValueListenableBuilder<bool>(
          valueListenable: isGrid,
          builder: (context, value, _) {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              transitionBuilder: (child, animation) {
                final offsetAnimation = Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(animation);
                return SlideTransition(position: offsetAnimation, child: child);
              },
              child: BlocProvider.value(
                value: widget.homeCubit,
                child: BlocBuilder<HomeCubit, HomeState>(
                  buildWhen:
                      (prev, curr) =>
                          prev.productsState != curr.productsState ||
                          prev.offersState != curr.offersState,
                  builder: (context, state) {
                    final List<ProductModel> discoverList =
                        widget.isOffer
                            ? state.offersModel.offers
                            : state.productsModel.groupedBrandProducts[widget
                                    .brand] ??
                                [];

                    final RequestStatus status =
                        widget.isOffer
                            ? state.offersState
                            : state.productsState;

                    _resetLoading(status);

                    if (value) {
                      return DiscoverGridView(
                        key: const ValueKey('grid'),
                        discoverList: discoverList,
                        controller: _scrollController,
                        status: status,
                      );
                    } else {
                      return DiscoverListView(
                        key: const ValueKey('list'),
                        discoverList: discoverList,
                        controller: _scrollController,
                        status: status,
                      );
                    }
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
