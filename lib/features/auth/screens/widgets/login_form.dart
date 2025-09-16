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

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late GlobalKey<FormState> _formKey;
  late AutovalidateMode _autovalidateMode;
  late String email, password;

  final ValueNotifier<bool> _rememberMeNotifier = ValueNotifier(false);

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _autovalidateMode = AutovalidateMode.disabled;
    super.initState();
  }

  @override
  void dispose() {
    _rememberMeNotifier.dispose();
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
              type: TextInputType.emailAddress,
              autofillHints: const [AutofillHints.email],
              hintText: "Email",
              label: "Email",
              prefixIcon: Icon(
                FontAwesomeIcons.envelope,
                color: Theme.of(
                  context,
                ).colorScheme.onSurfaceVariant.withAlpha(153),
              ),
              onSaved: (value) => email = value!,
            ),
            const SizedBox(height: 16.0),
            PasswordField(
              onSaved: (value) => password = value!,
              onSubmit: (_) => _onSubmit(),
            ),
            const SizedBox(height: 24.0),
            Row(
              children: [
                ValueListenableBuilder<bool>(
                  valueListenable: _rememberMeNotifier,
                  builder: (context, isChecked, _) {
                    return AuthCustomCheckBox(
                      value: isChecked,
                      onChanged: (value) => _rememberMeNotifier.value = value,
                    );
                  },
                ),
                const SizedBox(width: 8.0),
                Text(
                  "Remember me",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    context.pushRoute(const ForgetPasswordRoute());
                  },
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
            BlocConsumer<AuthCubit, AuthState>(
              buildWhen:
                  (previous, current) =>
                      previous.loginRequestStatus != current.loginRequestStatus,
              listenWhen:
                  (previous, current) =>
                      previous.loginRequestStatus != current.loginRequestStatus,
              listener: (context, state) {
                if (state.loginRequestStatus.isSuccess) {
                  showToast(
                    message: "login successfully",
                    state: ToastStates.success,
                  );
                  context.replaceRoute(const AuthenticatedRoute());
                }
                if (state.loginRequestStatus.isError) {
                  showToast(
                    message: state.authErrorMessage,
                    state: ToastStates.error,
                  );
                }
              },
              builder: (context, state) {
                return PrimaryButton(
                  isLoading: state.loginRequestStatus.isLoading,
                  onPressed: () => _onSubmit(),
                  text: "Log in",
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      context.read<AuthCubit>().userLogin(
        email: email.trim(),
        password: password.trim(),
      );
    } else {
      setState(() {
        _autovalidateMode = AutovalidateMode.always;
      });
      TextInput.finishAutofillContext();
    }
  }
}
