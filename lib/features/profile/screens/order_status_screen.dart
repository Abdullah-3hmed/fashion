import 'package:auto_route/auto_route.dart';
import 'package:e_fashion_flutter/core/utils/assets_manager.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StepModel {
  final String title;
  final String image;
  final String imageText;

  StepModel({
    required this.title,
    required this.image,
    required this.imageText,
  });
}

@RoutePage()
class OrderStatusScreen extends StatefulWidget {
  const OrderStatusScreen({super.key});

  @override
  State<OrderStatusScreen> createState() => _OrderStatusScreenState();
}

class _OrderStatusScreenState extends State<OrderStatusScreen> {
  int index = 0;
  List<StepModel> steps = <StepModel>[
    StepModel(
      title: "On progress",
      image: AssetsManager.onProgressImage,
      imageText: "Your order still on progress \nit may take hours ",
    ),
    StepModel(
      title: "On its way",
      image: AssetsManager.onItsWayImage,
      imageText: "The delivery man on his \nway to your location ",
    ),
    StepModel(
      title: "Delivered",
      image: AssetsManager.deliveredImage,
      imageText: "Your order has been \ndelivered, hope you liked it",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order Status',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          EasyStepper(
            activeStep: index,
            lineStyle: LineStyle(
              lineType: LineType.normal,
              lineLength: 100,
              lineThickness: 2.0,
              unreachedLineColor: Theme.of(context).colorScheme.outlineVariant,
              defaultLineColor: Theme.of(context).colorScheme.outlineVariant,
            ),
            activeStepTextColor: Colors.black,
            internalPadding: 0,
            showLoadingAnimation: false,
            stepRadius: 12.0,
            stepAnimationCurve: Curves.fastOutSlowIn,
            stepAnimationDuration: const Duration(milliseconds: 600),
            reachedSteps: {index},
            activeStepBorderColor: Theme.of(context).colorScheme.primary,
            activeStepBorderType: BorderType.normal,
            borderThickness: 5.0,
            defaultStepBorderType: BorderType.normal,
            onStepReached: (value) {
              index = value;
              setState(() {});
            },
            unreachedStepBorderType: BorderType.normal,
            finishedStepBorderType: BorderType.normal,
            steps: [
              EasyStep(
                icon:
                    index == 0
                        ? const Icon(FontAwesomeIcons.check)
                        : const Icon(null),
                title: steps[0].title,
              ),
              EasyStep(
                icon:
                    index == 1
                        ? const Icon(FontAwesomeIcons.check)
                        : const Icon(null),
                title: steps[1].title,
              ),
              EasyStep(
                icon:
                    index == 2
                        ? const Icon(FontAwesomeIcons.check)
                        : const Icon(null),
                title: steps[2].title,
              ),
            ],
          ),
          const Spacer(),
          Image.asset(width: 215.0, height: 215.0, steps[index].image),
          const SizedBox(height: 24),
          Text(
            steps[index].imageText,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
