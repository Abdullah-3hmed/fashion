import 'package:auto_route/auto_route.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/filter_section.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/home_header.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/offers_section.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [HomeHeader(), FilterSection(), OffersSection()],
        ),
      ),
    );
  }
}
