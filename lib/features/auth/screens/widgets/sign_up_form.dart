import 'package:auto_route/auto_route.dart';
import 'package:e_fashion_flutter/config/router/app_router.dart';
import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/core/utils/show_toast.dart';
import 'package:e_fashion_flutter/core/widgets/custom_text_form_field.dart';
import 'package:e_fashion_flutter/core/widgets/password_field.dart';
import 'package:e_fashion_flutter/core/widgets/primary_button.dart';
import 'package:e_fashion_flutter/features/auth/cubit/auth_cubit.dart';
import 'package:e_fashion_flutter/features/auth/cubit/auth_state.dart';
import 'package:e_fashion_flutter/features/auth/screens/widgets/auth_custom_check_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:solar_icons/solar_icons.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  late String name, email, phone, password;
  late AutovalidateMode _autovalidateMode;
  late GlobalKey<FormState> _formKey;
  late final ValueNotifier<bool> _isPrivacyAccepted;
  late final ValueNotifier<bool> _isPrivacyError;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _autovalidateMode = AutovalidateMode.disabled;
    _isPrivacyAccepted = ValueNotifier(false);
    _isPrivacyError = ValueNotifier(false);
    super.initState();
  }

  @override
  void dispose() {
    _isPrivacyAccepted.dispose();
    _isPrivacyError.dispose();
    super.dispose();
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
              onSaved: (value) => name = value!,
            ),
            const SizedBox(height: 16.0),
            CustomTextFormField(
              type: TextInputType.text,
              hintText: "Email",
              label: "Email",
              autofillHints: const [AutofillHints.email],
              prefixIcon: Icon(
                FontAwesomeIcons.envelope,
                color: Theme.of(
                  context,
                ).colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
              ),
              onSubmit: (_) {},
              onSaved: (value) => email = value!,
            ),
            const SizedBox(height: 16.0),
            CustomTextFormField(
              type: TextInputType.phone,
              hintText: "Phone",
              label: "Phone",
              autofillHints: const [AutofillHints.telephoneNumber],
              prefixIcon: const Icon(SolarIconsOutline.phone),
              onSaved: (value) => phone = value!,
            ),
            const SizedBox(height: 16.0),
            PasswordField(
              onSaved: (value) => password = value!,
              onSubmit: (_) => _onSubmit(),
            ),
            const SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ValueListenableBuilder<bool>(
                  valueListenable: _isPrivacyError,
                  builder: (context, isError, _) {
                    return ValueListenableBuilder<bool>(
                      valueListenable: _isPrivacyAccepted,
                      builder: (context, isAccepted, _) {
                        return AuthCustomCheckBox(
                          isError: isError,
                          value: isAccepted,
                          onChanged: (bool isChecked) {
                            _isPrivacyAccepted.value = isChecked;
                            if (isChecked) _isPrivacyError.value = false;
                          },
                        );
                      },
                    );
                  },
                ),
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
            BlocConsumer<AuthCubit, AuthState>(
              listenWhen:
                  (previous, current) =>
                      previous.signUpRequestStatus !=
                      current.signUpRequestStatus,
              buildWhen:
                  (previous, current) =>
                      previous.signUpRequestStatus !=
                      current.signUpRequestStatus,

              listener: (context, state) {
                if (state.signUpRequestStatus.isSuccess) {
                  showToast(
                    message: state.authResponseModel.message,
                    state: ToastStates.success,
                  );
                  context.replaceRoute(const AuthenticatedRoute());
                }
                if (state.signUpRequestStatus.isError) {
                  showToast(
                    message: state.authErrorMessage,
                    state: ToastStates.error,
                  );
                }
              },
              builder: (context, state) {
                return PrimaryButton(
                  isLoading: state.signUpRequestStatus.isLoading,
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: _onSubmit,
                  text: "Sign up",
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate() && _isPrivacyAccepted.value) {
      _formKey.currentState!.save();
      context.read<AuthCubit>().userSignUp(
        name: name,
        email: email.trim(),
        phone: phone,
        password: password.trim(),
      );
    } else {
      _autovalidateMode = AutovalidateMode.always;
      _isPrivacyError.value = true;
      TextInput.finishAutofillContext();
      setState(() {});
    }
  }
}
