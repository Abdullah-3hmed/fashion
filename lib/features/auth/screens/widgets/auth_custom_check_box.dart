import 'package:e_fashion_flutter/core/utils/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AuthCustomCheckBox extends StatefulWidget {
  const AuthCustomCheckBox({super.key});

  @override
  State<AuthCustomCheckBox> createState() => _AuthCustomCheckBoxState();
}

class _AuthCustomCheckBoxState extends State<AuthCustomCheckBox> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isChecked = !isChecked;
        });
      },
      child: AnimatedContainer(
        width: 24,
        height: 24,
        duration: const Duration(milliseconds: 100),
        decoration: ShapeDecoration(
          color:
              isChecked
                  ? Theme.of(context).colorScheme.primary
                  : Colors.transparent,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1.50,
              color:
                  isChecked
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.outline,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child:
            isChecked
                ? Padding(
                  padding: const EdgeInsets.all(2),
                  child: SvgPicture.asset(AssetsManager.check),
                )
                : const SizedBox(),
      ),
    );
  }
}
