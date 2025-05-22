import 'package:auto_route/auto_route.dart';
import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/core/utils/show_toast.dart';
import 'package:e_fashion_flutter/core/utils/toast_states.dart';
import 'package:e_fashion_flutter/core/widgets/primary_button.dart';
import 'package:e_fashion_flutter/features/home/cubit/home_cubit.dart';
import 'package:e_fashion_flutter/features/home/cubit/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EditReviewSection extends StatefulWidget {
  const EditReviewSection({super.key, required this.productId});

  final int productId;

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
        RatingBar.builder(
          allowHalfRating: true,
          initialRating: context.watch<HomeCubit>().state.rating,
          itemSize: 32.0,
          itemPadding: const EdgeInsets.symmetric(horizontal: 18.0),
          itemBuilder:
              (context, _) =>
                  const Icon(FontAwesomeIcons.solidStar, color: Colors.amber),
          onRatingUpdate: (double value) {
            context.read<HomeCubit>().rateProduct(rating: value);
          },
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
        BlocConsumer<HomeCubit, HomeState>(
          listenWhen:
              (previous, current) =>
                  previous.addReviewStatus != current.addReviewStatus,
          buildWhen:
              (previous, current) =>
                  previous.addReviewStatus != current.addReviewStatus,
          listener: (context, state) {
            if (state.addReviewStatus == RequestStatus.success) {
              context.read<HomeCubit>().rateProduct(rating: 0.0);
              context.pop();
              showToast(
                message: "Review added successfully",
                state: ToastStates.success,
              );
            }
            if (state.addReviewStatus == RequestStatus.error) {
              showToast(
                message: state.addReviewErrorMessage,
                state: ToastStates.error,
              );
            }
          },
          builder: (context, state) {
            return PrimaryButton(
              isLoading: state.addReviewStatus == RequestStatus.loading,
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

  Future<void> _onPressed() async {
    if (review.isNotEmpty) {
      await context.read<HomeCubit>().addReview(
        productId: widget.productId,
        review: review,
      );
    } else {
      showToast(message: "please enter review", state: ToastStates.error);
    }
  }
}
