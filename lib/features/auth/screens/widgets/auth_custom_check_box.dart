import 'package:flutter/material.dart';

class AuthCustomCheckBox extends StatefulWidget {
  final bool isError;
  final ValueChanged<bool> onChanged;

  const AuthCustomCheckBox({
    super.key,
    required this.onChanged,
    required this.isError,
  });

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
        widget.onChanged(isChecked);
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
                      : widget.isError
                      ? Colors.red
                      : Theme.of(context).colorScheme.outline,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child:
            isChecked
                ? const Padding(
                  padding: EdgeInsets.all(2),
                  child: Icon(Icons.check_sharp, color: Colors.white, size: 18),
                )
                : const SizedBox(),
      ),
    );
  }
}
