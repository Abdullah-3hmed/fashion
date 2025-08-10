import 'package:auto_route/auto_route.dart';
import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/core/utils/show_toast.dart';
import 'package:e_fashion_flutter/core/utils/toast_states.dart';
import 'package:e_fashion_flutter/core/widgets/primary_button.dart';
import 'package:e_fashion_flutter/features/home/cubit/home_cubit.dart';
import 'package:e_fashion_flutter/features/home/cubit/home_state.dart';
import 'package:e_fashion_flutter/features/home/cubit/product_details_cubit.dart';
import 'package:e_fashion_flutter/features/home/cubit/product_details_state.dart';
import 'package:e_fashion_flutter/features/home/data/home_details/review_model.dart';
import 'package:e_fashion_flutter/features/profile/cubit/user_cubit.dart';
import 'package:e_fashion_flutter/features/profile/data/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class EditReviewSection extends StatefulWidget {
  const EditReviewSection({super.key, required this.productId});

  final String productId;

  @override
  State<EditReviewSection> createState() => _EditReviewSectionState();
}

class _EditReviewSectionState extends State<EditReviewSection> {
  late String review;

  @override
  void initState() {
    super.initState();
    review = "";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: RatingBar.builder(
            allowHalfRating: true,
            initialRating: context.select(
              (ProductDetailsCubit cubit) => cubit.state.rate,
            ),
            itemSize: 32.0,
            itemPadding: const EdgeInsets.symmetric(horizontal: 14.0),
            itemBuilder:
                (context, _) =>
                    const Icon(FontAwesomeIcons.solidStar, color: Colors.amber),
            onRatingUpdate: (double value) {
              context.read<ProductDetailsCubit>().rateProduct(rate: value);
            },
          ),
        ),
        const SizedBox(height: 40.0),
        TextField(
          maxLength: 200,
          onSubmitted: (_) async {
            await _onPressed();
          },
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
        BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
          listenWhen:
              (previous, current) =>
                  previous.addReviewState != current.addReviewState,
          buildWhen:
              (previous, current) =>
                  previous.addReviewState != current.addReviewState,
          listener: (context, state) {
            if (state.addReviewState.isSuccess) {
              context.pop();
              showToast(
                message: "Review added successfully",
                state: ToastStates.success,
              );
            }
            if (state.addReviewState.isError) {
              showToast(
                message: state.addReviewErrorMessage,
                state: ToastStates.error,
              );
            }
          },
          builder: (context, state) {
            return PrimaryButton(
              isLoading: state.addReviewState.isLoading,
              onPressed: () async {
                await _onPressed();
              },
              text: "Post review",
            );
          },
        ),
      ],
    );
  }

  Future<void>   _onPressed() async {
    final UserModel userModel = context.read<UserCubit>().state.userModel;
   final DateTime today = DateTime.now();
    String formattedDate = DateFormat('yyyy-M-d').format(today);

    ReviewModel reviewModel = ReviewModel(
      productId: widget.productId,
      review: review,
      rate: context.read<ProductDetailsCubit>().state.rate.toInt(),
      imageUrl: userModel.profileImage,
      name: userModel.userName,
      reviewId: "",
      createdAt: formattedDate
    );
    await context.read<ProductDetailsCubit>().addReview(
      reviewModel: reviewModel,
    );
  }
}
