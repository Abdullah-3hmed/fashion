import 'package:e_fashion_flutter/core/utils/assets_manager.dart';
import 'package:e_fashion_flutter/core/widgets/custom_text_form_field.dart';
import 'package:e_fashion_flutter/core/widgets/primary_button.dart';
import 'package:e_fashion_flutter/features/auth_feature/screens/widgets/auth_custom_check_box.dart';
import 'package:e_fashion_flutter/features/auth_feature/screens/widgets/password_filed.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late GlobalKey<FormState> _formKey;
  late AutovalidateMode _autovalidateMode;
  late String email, password;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _autovalidateMode = AutovalidateMode.disabled;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: _autovalidateMode,
      child: AutofillGroup(
        child: Column(
          children: [
            CustomTextFormField(
              type: TextInputType.emailAddress,
              isEmail: true,
              autofillHints: const [AutofillHints.email],
              hintText: "Email",
              label: "Email",
              prefixIcon: SvgPicture.asset(
                colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.onPrimaryContainer,
                  BlendMode.srcIn,
                ),
                fit: BoxFit.scaleDown,
                AssetsManager.email,
              ),
              onSaved: (value) {
                email = value!;
              },
              onSubmit: (_) {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  debugPrint('Form is valid');
                  debugPrint(email);
                  debugPrint(password);
                } else {
                  setState(() {
                    _autovalidateMode = AutovalidateMode.always;
                  });
                  TextInput.finishAutofillContext();
                }
              },
            ),
            const SizedBox(height: 16.0),
            PasswordField(
              onSaved: (value) {
                password = value!;
              },
            ),
            const SizedBox(height: 24.0),
            Row(
              children: [
                const AuthCustomCheckBox(),
                const SizedBox(width: 8.0),
                Text(
                  "Remember me",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Forget Password",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 48.0),
            PrimaryButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  debugPrint('Form is valid');
                  debugPrint(email);
                  debugPrint(password);
                } else {
                  setState(() {
                    _autovalidateMode = AutovalidateMode.always;
                  });
                }
              },
              text: "Log in",
            ),
          ],
        ),
      ),
    );
  }
}
