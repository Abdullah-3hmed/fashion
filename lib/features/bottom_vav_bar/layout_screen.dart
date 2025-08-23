import 'package:auto_route/auto_route.dart';
import 'package:e_fashion_flutter/config/router/app_router.dart';
import 'package:e_fashion_flutter/core/notifications/fcm_init_helper.dart';
import 'package:e_fashion_flutter/core/services/service_locator.dart';
import 'package:e_fashion_flutter/core/utils/app_constants.dart';
import 'package:e_fashion_flutter/features/cart/cubit/cart_cubit.dart';
import 'package:e_fashion_flutter/features/cart/cubit/cart_state.dart';
import 'package:e_fashion_flutter/shared/app_cubit/app_cubit.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:solar_icons/solar_icons.dart';

@RoutePage()
class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
    });

    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      routes: const [HomeRoute(), CartRoute(), FavoriteRoute(), ProfileRoute()],
      bottomNavigationBuilder:
          (_, tabsRouter) => Container(
            height: 70.0,
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(20.0),
            ),
            margin: const EdgeInsets.only(
              bottom: 16.0,
              left: 16.0,
              right: 16.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    tabsRouter.setActiveIndex(0);
                  },
                  icon: Icon(
                    SolarIconsOutline.home2,
                    color:
                        tabsRouter.activeIndex == 0
                            ? Theme.of(context).colorScheme.primary
                            : Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    tabsRouter.setActiveIndex(1);
                  },
                  icon: Icon(
                    Iconsax.bag_2,
                    color:
                        tabsRouter.activeIndex == 1
                            ? Theme.of(context).colorScheme.primary
                            : Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    tabsRouter.setActiveIndex(2);
                  },
                  icon: Icon(
                    SolarIconsOutline.heart,
                    color:
                        tabsRouter.activeIndex == 2
                            ? Theme.of(context).colorScheme.primary
                            : Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    tabsRouter.setActiveIndex(3);
                  },
                  icon: Icon(
                    SolarIconsOutline.user,
                    color:
                        tabsRouter.activeIndex == 3
                            ? Theme.of(context).colorScheme.primary
                            : Colors.white,
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
