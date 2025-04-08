import 'package:auto_route/auto_route.dart';
import 'package:e_fashion_flutter/config/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:solar_icons/solar_icons.dart';

@RoutePage()
class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

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
                    SolarIconsOutline.cart,
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
