import 'package:auto_route/auto_route.dart';
import 'package:e_fashion_flutter/core/utils/assets_manager.dart';
import 'package:e_fashion_flutter/core/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

@RoutePage()
class EditReviewScreen extends StatelessWidget {
  const EditReviewScreen({super.key, required this.rating});

  final double rating;

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
                    child: Image.asset(
                      height: 140.0,
                      width: 120.0,
                      AssetsManager.welcomeImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Denim Jacket",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        r"$200.00",
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
                    backgroundImage:
                        Image.asset(AssetsManager.welcomeImage).image,
                  ),
                  const SizedBox(width: 16.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Kira Alan",
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
                initialRating: rating,
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
                onSubmitted: (value) {},
                onChanged: (value) {},
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
              PrimaryButton(onPressed: () {}, text: "Post review"),
            ],
          ),
        ),
      ),
    );
  }
}
