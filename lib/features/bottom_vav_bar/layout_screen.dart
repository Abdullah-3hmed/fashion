import 'package:auto_route/auto_route.dart';
import 'package:e_fashion_flutter/config/router/app_router.dart';
import 'package:flutter/material.dart';

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
            margin: const EdgeInsets.only(
              bottom: 16.0,
              left: 16.0,
              right: 16.0,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: BottomNavigationBar(
                selectedFontSize: 0,
                unselectedFontSize: 0,
                currentIndex: tabsRouter.activeIndex,
                onTap: tabsRouter.setActiveIndex,
                items: const [
                  BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart),
                    label: "",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.favorite),
                    label: "",
                  ),
                  BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
                ],
              ),
            ),
          ),
    );
  }
}
