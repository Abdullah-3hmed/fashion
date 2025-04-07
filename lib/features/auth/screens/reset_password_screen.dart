import 'package:auto_route/auto_route.dart';
import 'package:e_fashion_flutter/core/widgets/primary_button.dart';
import 'package:e_fashion_flutter/features/auth/screens/widgets/auth_background_image_and_logo.dart';
import 'package:e_fashion_flutter/features/auth/screens/widgets/password_filed.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  late final GlobalKey<FormState> _formKey;

  late AutovalidateMode _autovalidateMode;
  late String _password;
  late String _confirmPassword;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _autovalidateMode = AutovalidateMode.disabled;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackgroundImageAndLogo(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: _formKey,
              autovalidateMode: _autovalidateMode,
              child: Column(
                children: [
                  Text(
                    "Reset Password",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    "Your new password must be different \n from previous used password  ",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 24.0),
                  PasswordField(
                    textInputAction: TextInputAction.next,
                    onSaved: (value) {
                      _password = value!;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  PasswordField(
                    label: "Confirm Password",
                    hintText: "Confirm Password",
                    onSaved: (value) {
                      _confirmPassword = value!;
                    },
                    onSubmit: (_) {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        debugPrint("Password: $_password");
                        debugPrint("Confirm Password: $_confirmPassword");
                      } else {
                        setState(() {
                          _autovalidateMode = AutovalidateMode.always;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 28.0),
                  PrimaryButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        debugPrint("Password: $_password");
                        debugPrint("Confirm Password: $_confirmPassword");
                      } else {
                        setState(() {
                          _autovalidateMode = AutovalidateMode.always;
                        });
                      }
                    },
                    text: "Continue",
                  ),
                  const SizedBox(height: 50.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
