import 'package:e_fashion_flutter/core/widgets/primary_button.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/shared/colors_available.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/shared/pieces_available.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/shared/sizes_available.dart';
import 'package:e_fashion_flutter/shared/data/bottom_sheet_model.dart';
import 'package:e_fashion_flutter/shared/data/product_model.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ModalBottomSheetContent extends StatelessWidget {
  const ModalBottomSheetContent({super.key, required this.bottomSheetModel});
final BottomSheetModel bottomSheetModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.all(24.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: const BorderRadiusDirectional.only(
          topEnd: Radius.circular(30.0),
          topStart: Radius.circular(30.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
              bottomSheetModel.title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(width: 46.0),
              Text(r"$""${bottomSheetModel.basePrice}", style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
          const SizedBox(height: 30.0),
          ColorsAvailable(
            colors: bottomSheetModel.colors,
            onColorChanged: (index) => debugPrint(index.toString()),
          ),
          const SizedBox(height: 24.0),
          SizesAvailable(
            sizes: bottomSheetModel.sizes,
            onColorChanged: (size) {
              debugPrint(size);
            },
          ),
          const SizedBox(height: 22),
          PiecesAvailable(
            onPiecesChanged: (value) {
              debugPrint(value.toString());
            },
          ),
          const SizedBox(height: 37),
          PrimaryButton(
            onPressed: () {},
            text: "Add to bag",
            icon: Icon(
              Iconsax.bag_2,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
