import 'package:e_fashion_flutter/core/widgets/custom_text_form_field.dart';
import 'package:e_fashion_flutter/core/widgets/password_filed.dart';
import 'package:e_fashion_flutter/core/widgets/primary_button.dart';
import 'package:e_fashion_flutter/features/auth/screens/widgets/auth_custom_check_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:solar_icons/solar_icons.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  late String name, email, password;
  late AutovalidateMode _autovalidateMode;
  late GlobalKey<FormState> _formKey;

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
              type: TextInputType.text,
              hintText: "Name",
              label: "Name",
              autofillHints: const [AutofillHints.name],
              prefixIcon: const Icon(SolarIconsOutline.user),

              onSaved: (value) {
                name = value!;
              },
            ),
            const SizedBox(height: 16.0),
            CustomTextFormField(
              type: TextInputType.text,
              hintText: "Email",
              label: "Email",
              autofillHints: const [AutofillHints.email],
              isEmail: true,
              prefixIcon: Icon(
                FontAwesomeIcons.envelope,
                color: Theme.of(
                  context,
                ).colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
              ),
              onSubmit: (_) {},
              onSaved: (value) {
                email = value!;
              },
            ),
            const SizedBox(height: 16.0),
            PasswordField(
              onSaved: (value) {
                password = value!;
              },
              onSubmit: (_) {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  debugPrint('Form is valid');
                  debugPrint(name);
                  debugPrint(email);
                } else {
                  setState(() {
                    _autovalidateMode = AutovalidateMode.always;
                  });
                }
                TextInput.finishAutofillContext();
              },
            ),
            const SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AuthCustomCheckBox(),
                const SizedBox(width: 8.0),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "I Agree with",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      TextSpan(
                        text: " Privacy",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),

                      TextSpan(
                        text: " and",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      TextSpan(
                        text: " policy",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 48),
            PrimaryButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  debugPrint('Form is valid');
                  debugPrint(name);
                  debugPrint(email);
                  debugPrint(password);
                } else {
                  setState(() {
                    _autovalidateMode = AutovalidateMode.always;
                  });
                  TextInput.finishAutofillContext();
                }
              },
              text: "Sign up",
            ),
          ],
        ),
      ),
    );
  }
}
