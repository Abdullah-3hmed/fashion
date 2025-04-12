import 'package:auto_route/auto_route.dart';
import 'package:e_fashion_flutter/core/widgets/secondary_button.dart';
import 'package:e_fashion_flutter/features/auth/screens/widgets/password_filed.dart';
import 'package:e_fashion_flutter/features/profile/screens/widgets/profile_background_image_and_logo.dart';
import 'package:e_fashion_flutter/features/profile/screens/widgets/profile_clipped_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

@RoutePage()
class ProfileChangePasswordScreen extends StatefulWidget {
  const ProfileChangePasswordScreen({super.key});

  @override
  State<ProfileChangePasswordScreen> createState() =>
      _ProfileChangePasswordScreenState();
}

class _ProfileChangePasswordScreenState
    extends State<ProfileChangePasswordScreen> {
  late GlobalKey<FormState> _formKey;
  late AutovalidateMode _autovalidateMode;
  late String oldPassword;
  late String newPassword;
  late String confirmPassword;
  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _autovalidateMode = AutovalidateMode.disabled;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProfileBackgroundImageAndLogo(
        child: ProfileClippedContainer(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: _formKey,
              autovalidateMode: _autovalidateMode,
              child: AutofillGroup(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40.0),
                    InkWell(
                      onTap: () {
                        context.pop();
                      },
                      child: CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        radius: 24.0,
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      "Change password",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 50.0),
                    PasswordField(
                      onSaved: (value) {
                        oldPassword = value!;
                      },
                      onSubmit: (_) {
                        _onPressed();
                      },
                      hintText: "old password",
                      label: "old password",
                    ),
                    const SizedBox(height: 16.0),
                    PasswordField(
                      onSaved: (value) {
                        newPassword = value!;
                      },
                      onSubmit: (_) {
                        _onPressed();
                      },
                      hintText: "new password",
                      label: "new password",
                    ),
                    const SizedBox(height: 16.0),
                    PasswordField(
                      onSaved: (value) {
                        confirmPassword = value!;
                      },
                      onSubmit: (_) {
                        _onPressed();
                      },
                      hintText: "confirm password",
                      label: "confirm password",
                    ),
                    const SizedBox(height: 85.0),
                    Align(
                      child: SecondaryButton(
                        onPressed: () {
                          _onPressed();
                        },
                        text: "done",
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.secondary.withValues(alpha: 0.5),
                      ),
                    ),
                    const SizedBox(height: 100.0),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onPressed() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      debugPrint('Form is valid');
      debugPrint(oldPassword);
      debugPrint(newPassword);
      debugPrint(confirmPassword);
    } else {
      setState(() {
        _autovalidateMode = AutovalidateMode.always;
      });
    }
    TextInput.finishAutofillContext();
  }
}
