import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/core/widgets/primary_button.dart';
import 'package:e_fashion_flutter/features/home/cubit/home_cubit.dart';
import 'package:e_fashion_flutter/features/home/cubit/home_state.dart';
import 'package:e_fashion_flutter/features/home/data/product_details_model.dart';
import 'package:e_fashion_flutter/features/profile/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

@RoutePage()
class EditReviewScreen extends StatefulWidget {
  const EditReviewScreen({
    super.key,
    required this.productDetailsModel,
    required this.rating,
  });

  final ProductDetailsModel productDetailsModel;
  final double rating;

  @override
  State<EditReviewScreen> createState() => _EditReviewScreenState();
}

class _EditReviewScreenState extends State<EditReviewScreen> {
  String review = "";

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
                    child: CachedNetworkImage(
                      imageUrl: widget.productDetailsModel.productImage,
                      height: 140.0,
                      width: 120.0,
                      fit: BoxFit.cover,
                      errorWidget:
                          (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.productDetailsModel.productName,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        r"$"
                        "${widget.productDetailsModel.price}",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 32.0),
              Row(
                children: [
                  CircleAvatar(
                    radius: 20.0,
                    backgroundImage: CachedNetworkImageProvider(
                      context.select(
                        (UserCubit cubit) => cubit.state.userModel.profileImage,
                      ),
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
              RatingBar.builder(
                allowHalfRating: true,
                initialRating: widget.rating,
                itemSize: 32.0,
                itemPadding: const EdgeInsets.symmetric(horizontal: 18.0),
                itemBuilder:
                    (context, _) => const Icon(
                      FontAwesomeIcons.solidStar,
                      color: Colors.amber,
                    ),
                onRatingUpdate: (double value) {},
              ),
              const SizedBox(height: 40.0),
              TextField(
                maxLength: 200,
                onSubmitted: (_) {},
                onChanged: (value) {
                  review = value;
                },
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
                decoration: InputDecoration(
                  hintText: "Describe your opinion",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.outlineVariant,
                    ),
                  ),
                  counterStyle: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              const SizedBox(height: 140.0),
              BlocConsumer<HomeCubit, HomeState>(
                listenWhen:
                    (previous, current) =>
                        previous.addReviewStatus != current.addReviewStatus,
                buildWhen:
                    (previous, current) =>
                        previous.addReviewStatus != previous.addReviewStatus,
                listener: (context, state) {
                  if (state.addReviewStatus == RequestStatus.success) {
                    context.pop();
                  }
                },
                builder: (context, state) {
                  return PrimaryButton(
                    isLoading: state.addReviewStatus == RequestStatus.loading,
                    onPressed: () async {
                      await context.read<HomeCubit>().addReview(
                        productId: widget.productDetailsModel.id,
                        rating: widget.rating.toInt(),
                        review: review,
                      );
                    },
                    text: "Post review",
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
