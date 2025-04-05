import 'package:e_fashion_flutter/core/utils/assets_manager.dart';
import 'package:e_fashion_flutter/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({super.key, required this.onSaved});

  final void Function(String?)? onSaved;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obsecureText = true;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      type: TextInputType.visiblePassword,
      hintText: "Password",
      label: "Password",
      textInputAction: TextInputAction.done,
      prefixIcon: SvgPicture.asset(
        colorFilter: ColorFilter.mode(
          Theme.of(context).colorScheme.onPrimaryContainer,
          BlendMode.srcIn,
        ),
        fit: BoxFit.scaleDown,
        AssetsManager.lock,
      ),
      autofillHints: const [AutofillHints.password],
      obscureText: _obsecureText,
      suffixIcon: IconButton(
        onPressed: () {
          _obsecureText = !_obsecureText;
          setState(() {});
        },
        icon:
            _obsecureText
                ? const Icon(Icons.visibility_outlined)
                : const Icon(Icons.visibility_off, color: Color(0xFFC9CECF)),
      ),
      onSaved: widget.onSaved,
    );
  }
}
