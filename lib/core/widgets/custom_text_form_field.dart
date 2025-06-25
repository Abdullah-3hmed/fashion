import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.controller,
    required this.type,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.label,
    this.onSuffixPress,
    this.hintText,
    this.onSubmit,
    this.borderRadius,
    this.enableBorderColor,
    this.onSaved,
    this.autofillHints,
    this.fillColor,
    this.textInputAction,
    this.contentPadding = 20.0,
  });

  final TextEditingController? controller;
  final TextInputType type;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final String? label;
  final List<String>? autofillHints;
  final Function(String submittedText)? onSubmit;
  final Function(String? value)? onSaved;
  final VoidCallback? onSuffixPress;
  final String? hintText;
  final double? borderRadius;
  final Color? enableBorderColor;
  final Color? fillColor;
  final double contentPadding;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textInputAction: textInputAction ?? TextInputAction.next,
      keyboardType: type,
      obscureText: obscureText,
      onSaved: onSaved,
      autofillHints: autofillHints,
      onFieldSubmitted: onSubmit,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor ?? Colors.transparent,
        errorStyle: Theme.of(context).textTheme.bodySmall,
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.bodySmall,
        errorMaxLines: 1,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        labelText: label,
        labelStyle: Theme.of(context).textTheme.bodySmall,
        contentPadding: EdgeInsets.all(contentPadding),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
          borderSide: BorderSide(
            color: enableBorderColor ?? Theme.of(context).colorScheme.outline,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.error),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
          borderSide: BorderSide(
            color: enableBorderColor ?? Theme.of(context).colorScheme.outline,
          ),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return '$label required';
        }
        return null;
      },
    );
  }
}
