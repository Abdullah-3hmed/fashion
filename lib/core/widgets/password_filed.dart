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

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }

    final hasUppercase = value.contains(RegExp(r'[A-Z]'));
    final hasLowercase = value.contains(RegExp(r'[a-z]'));
    final hasDigit = value.contains(RegExp(r'\d'));

    final minLength = value.length >= 8;

    if (!hasUppercase)
      return "Password must contain at least one uppercase letter";
    if (!hasLowercase)
      return "Password must contain at least one lowercase letter";
    if (!hasDigit) return "Password must contain at least one number";
    if (!minLength) return "Password must be at least 8 characters long";

    return null;
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
            icon:
                isObscured
                    ? const Icon(Icons.visibility_outlined)
                    : const Icon(
                      Icons.visibility_off,
                      color: Color(0xFFC9CECF),
                    ),
          ),
          onSaved: widget.onSaved,
          onSubmit: widget.onSubmit,
          validator: _validatePassword,
        );
      },
    );
  }
}
