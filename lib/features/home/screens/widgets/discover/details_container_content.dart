import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/core/utils/app_constants.dart';
import 'package:e_fashion_flutter/core/widgets/primary_button.dart';
import 'package:e_fashion_flutter/features/home/cubit/home_cubit.dart';
import 'package:e_fashion_flutter/features/home/cubit/home_state.dart';
import 'package:e_fashion_flutter/features/home/data/product_details_model.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/details/product_details.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/shared/colors_available.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/shared/pieces_available.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DetailsContainerContent extends StatelessWidget {
  const DetailsContainerContent({super.key, required this.controller});

  final ScrollController controller;
  static const ProductDetailsModel dummyProductDetailsModel =
      ProductDetailsModel(
        id: 1,
        productName: "Product Name",
        price: 99.99,
        description: "Description",
        productImage: AppConstants.imageUrl,
        reviews: [],
      );
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen:
          (previous, current) =>
              previous.productDetailsStatus != current.productDetailsStatus,
      builder: (context, state) {
        switch (state.productDetailsStatus) {
          case RequestStatus.loading:
            return Skeletonizer(
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
                    dummyProductDetailsModel.productName,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    r"$"
                    "${dummyProductDetailsModel.price}",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 24.0),
                  ColorsAvailable(
                    onColorChanged: (color) => debugPrint(color.toString()),
                  ),
                  PiecesAvailable(
                    onPiecesChanged: (int value) {
                      debugPrint(value.toString());
                    },
                  ),
                  Text(
                    dummyProductDetailsModel.description,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
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
            );
          case RequestStatus.success:
            return ProductDetails(
              controller: controller,
              productDetailsModel: state.productDetailsModel,
            );
          case RequestStatus.error:
            return SizedBox(
              height: 150.0,
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
}
