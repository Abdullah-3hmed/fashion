import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/core/utils/app_constants.dart';
import 'package:e_fashion_flutter/core/widgets/primary_button.dart';
import 'package:e_fashion_flutter/features/home/cubit/home_cubit/home_cubit.dart';
import 'package:e_fashion_flutter/features/home/cubit/home_cubit/home_state.dart';
import 'package:e_fashion_flutter/features/home/cubit/product_details_cubit/product_details_cubit.dart';
import 'package:e_fashion_flutter/features/home/cubit/product_details_cubit/product_details_state.dart';
import 'package:e_fashion_flutter/features/home/data/home_details/product_details_model.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/details/product_details.dart';
import 'package:e_fashion_flutter/shared/widgets/colors_available.dart';
import 'package:e_fashion_flutter/shared/widgets/pieces_available.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DetailsContainerContent extends StatelessWidget {
  const DetailsContainerContent({
    super.key,
    required this.controller,
    required this.productId,
  });
  final String productId;
  final ScrollController controller;
  static const ProductDetailsModel dummyProductDetailsModel =
      ProductDetailsModel(
        id: "",
        imageUrl: AppConstants.imageUrl,
        title: "Product Name",
        colors: "*****",
        price: 0.0,
        sizes: "*****",
        reviews: [],
      );
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      buildWhen:
          (previous, current) =>
              previous.productDetailsState != current.productDetailsState,
      builder: (context, state) {
        switch (state.productDetailsState) {
          case RequestStatus.loading:
            return _buildLoadingState(context);
          case RequestStatus.success:
            return ProductDetails(
              controller: controller,
              productDetailsModel: state.productDetailsModel,
            );
          case RequestStatus.error:
            return Center(
              child: Text(
                state.productDetailsErrorMessage,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            );
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }

  Skeletonizer _buildLoadingState(BuildContext context) {
    return Skeletonizer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30.0),
            CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              radius: 24.0,
              child: Icon(
                Icons.arrow_back,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            const SizedBox(height: 24.0),
            Text(
              dummyProductDetailsModel.title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              r"$"
              "${dummyProductDetailsModel.price}",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24.0),
            ColorsAvailable(
              colors: const [],
              onColorChanged: (color) => debugPrint(color.toString()),
            ),
            PiecesAvailable(
              onPiecesChanged: (int value) {
                debugPrint(value.toString());
              },
            ),
            Text("**********", style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 24.0),
            PrimaryButton(
              icon: Icon(
                Iconsax.bag_2,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              onPressed: () {},
              text: "Add to bag",
            ),
          ],
        ),
      ),
    );
  }
}
