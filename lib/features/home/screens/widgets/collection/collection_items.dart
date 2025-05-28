import 'dart:ui';

import 'package:e_fashion_flutter/core/notifications/fcm_helper.dart';
import 'package:e_fashion_flutter/core/services/service_locator.dart';
import 'package:e_fashion_flutter/core/widgets/secondary_button.dart';
import 'package:e_fashion_flutter/features/home/data/collection_details_model.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/collection/collection_container_clipper.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/collection/collection_item.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/collection/reverse_collection_item.dart';
import 'package:flutter/material.dart';

class CollectionItems extends StatelessWidget {
  const CollectionItems({super.key, required this.collectionDetailsModel});

  final CollectionDetailsModel collectionDetailsModel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemCount: collectionDetailsModel.collectionProducts.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16.0),
            itemBuilder:
                (context, index) =>
                    index % 2 == 0
                        ? CollectionItem(
                          product:
                              collectionDetailsModel.collectionProducts[index],
                        )
                        : ReverseCollectionItem(
                          product:
                              collectionDetailsModel.collectionProducts[index],
                        ),
          ),
        ),
        ClipPath(
          clipper: CollectionContainerClipper(),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
            child: Container(
              height: 192,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(255, 255, 255, 0.1),
                    Color.fromRGBO(36, 123, 160, 0.1),
                  ],
                ),
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
            ),
          ),
        ),
        PositionedDirectional(
          bottom: 100.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                r"$"
                "${collectionDetailsModel.totalPrice}",
                style: Theme.of(
                  context,
                ).textTheme.titleMedium!.copyWith(color: Colors.white),
              ),
              const SizedBox(width: 16.0),
              SecondaryButton(
                onPressed: () async {
                  await getIt<FcmHelper>().sendNotification(
                    token:
                        "e2CwU6F9Rg2MCNyYsx1gTB:APA91bFE3BKAvWlOg0S2fo2UL46vb8MEymLutL5Cb_mxdr0XVfF9C_7r4v7ci81eIpgcsAyfExqxRXv5ONcsyxVaTvyUmSAurmwwwmtteAvNKDsbydsOtE8",
                    title: "new message",
                    body: "test from abdullah",
                    data: {},
                  );
                },
                text: "Buy collection",
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
