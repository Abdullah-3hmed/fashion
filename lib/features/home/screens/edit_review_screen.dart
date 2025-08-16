import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_fashion_flutter/core/widgets/custom_cached_network_image.dart';
import 'package:e_fashion_flutter/features/home/cubit/product_details_cubit.dart';
import 'package:e_fashion_flutter/features/home/data/home_details/product_details_model.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/details/edit_review_section.dart';
import 'package:e_fashion_flutter/features/profile/cubit/user_cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class EditReviewScreen extends StatelessWidget implements AutoRouteWrapper {
  const EditReviewScreen({super.key, required this.productDetailsModel, required this.productDetailsCubit});

  final ProductDetailsModel productDetailsModel;
  final ProductDetailsCubit productDetailsCubit;
  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider.value(value: productDetailsCubit, child: this);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reviews", style: Theme.of(context).textTheme.titleMedium),
      ),
      body: Padding(
        padding: const EdgeInsetsDirectional.all(24.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadiusDirectional.circular(8.0),
                    child: CustomCachedNetworkImage(
                      imageUrl: productDetailsModel.imageUrl,
                      height: 140.0,
                      width: 120.0,
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productDetailsModel.title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        r"$"
                        "${productDetailsModel.price}",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 32.0),
              Row(
                children: [
                  Container(
                    width: 40.0,
                    height: 40.0,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: CustomCachedNetworkImage(
                      imageUrl: context.read<UserCubit>().state.userModel.profileImage,
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.select(
                          (UserCubit cubit) => cubit.state.userModel.userName,
                        ),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        "Reviews are public and include \n your account and device info",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30.0),
              EditReviewSection(productId: productDetailsModel.id),
            ],
          ),
        ),
      ),
    );
  }


}
