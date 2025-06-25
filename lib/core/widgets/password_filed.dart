import 'package:e_fashion_flutter/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:solar_icons/solar_icons.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    this.onSubmit,
    this.onSaved,
    this.hintText,
    this.label,
    this.textInputAction,
  });

  final void Function(String?)? onSaved;
  final void Function(String?)? onSubmit;
  final String? hintText;
  final String? label;
  final TextInputAction? textInputAction;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  final ValueNotifier<bool> _obscureTextNotifier = ValueNotifier(true);

  @override
  void dispose() {
    _obscureTextNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _obscureTextNotifier,
      builder: (context, isObscured, _) {
        return CustomTextFormField(
          type: TextInputType.visiblePassword,
          hintText: widget.hintText ?? "Password",
          label: widget.label ?? "Password",
          textInputAction: widget.textInputAction ?? TextInputAction.done,
          prefixIcon: const Icon(SolarIconsOutline.lockKeyhole),
          autofillHints: const [AutofillHints.password],
          obscureText: isObscured,
          suffixIcon: IconButton(
            onPressed: () => _obscureTextNotifier.value = !isObscured,
            icon: isObscured
                ? const Icon(Icons.visibility_outlined)
                : const Icon(Icons.visibility_off, color: Color(0xFFC9CECF)),
          ),
          onSaved: widget.onSaved,
          onSubmit: widget.onSubmit,
        );
      },
    );
  }
}
