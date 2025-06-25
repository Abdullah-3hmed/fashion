import 'package:flutter/material.dart';

class AuthCustomCheckBox extends StatelessWidget {
  final bool value;
  final bool isError;
  final ValueChanged<bool> onChanged;

  const AuthCustomCheckBox({
    super.key,
    required this.value,
    required this.onChanged,
     this.isError = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        width: 24,
        height: 24,
        duration: const Duration(milliseconds: 100),
        decoration: ShapeDecoration(
          color: value
              ? Theme.of(context).colorScheme.primary
              : Colors.transparent,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1.5,
              color: value
                  ? Theme.of(context).colorScheme.primary
                  : isError
                  ? Theme.of(context).colorScheme.error
                  : Theme.of(context).colorScheme.outline,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: value
            ? const Padding(
          padding: EdgeInsets.all(2),
          child: Icon(Icons.check_sharp, color: Colors.white, size: 18),
        )
            : const SizedBox.shrink(),
      ),
    );
  }
}
