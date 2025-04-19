import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
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
    this.isEmail = false,
    this.fillColor,
    this.textInputAction,
    this.contentPadding = 20.0,
  });

  final TextEditingController? controller;
  final TextInputType type;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final bool isEmail;
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
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      textInputAction: widget.textInputAction ?? TextInputAction.next,
      keyboardType: widget.type,
      obscureText: widget.obscureText,
      onSaved: widget.onSaved,
      autofillHints: widget.autofillHints,
      onFieldSubmitted: widget.onSubmit,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: widget.fillColor ?? Colors.transparent,
        errorStyle: Theme.of(context).textTheme.bodySmall,
        hintText: widget.hintText,
        hintStyle: Theme.of(context).textTheme.bodySmall,
        errorMaxLines: 1,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        labelText: widget.label,
        labelStyle: Theme.of(context).textTheme.bodySmall,
        contentPadding: EdgeInsets.all(widget.contentPadding),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 8.0),
          borderSide: BorderSide(
            color:
                widget.enableBorderColor ??
                Theme.of(context).colorScheme.outline,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 8.0),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 8.0),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.error),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 8.0),
          borderSide: BorderSide(
            color:
                widget.enableBorderColor ??
                Theme.of(context).colorScheme.outline,
          ),
        ),
      ),
      validator: (value) {
        if (widget.isEmail) {
          if (value!.isNotEmpty && !EmailValidator.validate(value)) {
            return "Enter a valid mail";
          }
        }
        if (value!.isEmpty) {
          return '${widget.label} required';
        }
        if (widget.obscureText) {
          final specialCharRegex = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
          if (!specialCharRegex.hasMatch(value)) {
            return 'Password must contain special characters';
          }
        }
        return null;
      },
    );
  }
}
