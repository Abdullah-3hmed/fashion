import 'package:auto_route/auto_route.dart';
import 'package:e_fashion_flutter/config/router/app_router.dart';
import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/core/utils/show_toast.dart';
import 'package:e_fashion_flutter/core/widgets/password_filed.dart';
import 'package:e_fashion_flutter/core/widgets/primary_button.dart';
import 'package:e_fashion_flutter/features/auth/cubit/auth_cubit.dart';
import 'package:e_fashion_flutter/features/auth/cubit/auth_state.dart';
import 'package:e_fashion_flutter/features/auth/screens/widgets/auth_background_image_and_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key, required this.email});
final String email;
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
        height: 540.0,
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
                    onSubmit: (_) async {
                      await _onSubmit();
                    },
                  ),
                  const SizedBox(height: 28.0),
                  BlocConsumer<AuthCubit, AuthState>(
                    buildWhen:
                        (previous, current) =>
                            previous.resetPasswordRequestStatus !=
                            current.resetPasswordRequestStatus,
                    listenWhen:
                        (previous, current) =>
                            previous.resetPasswordRequestStatus !=
                            current.resetPasswordRequestStatus,
                    listener: (context, state) {
                      if (state.resetPasswordRequestStatus.isSuccess) {
                        context.navigateTo(const LoginRoute());
                        showToast(
                          message: state.resetPasswordMessage,
                          state: ToastStates.success,
                        );
                      }
                      if (state.resetPasswordRequestStatus.isError) {
                        showToast(
                          message: state.resetPasswordErrorMessage,
                          state: ToastStates.error,
                        );
                      }
                    },
                    builder: (context, state) {
                      return PrimaryButton(
                        isLoading:
                            state.resetPasswordRequestStatus.isLoading,
                        onPressed: () async {
                          await _onSubmit();
                        },
                        text: "Continue",
                      );
                    },
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

  Future<void> _onSubmit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await context.read<AuthCubit>().resetPassword(
        email: widget.email,
        newPassword: _password,
        confirmPassword: _confirmPassword,
      );
    } else {
      setState(() {
        _autovalidateMode = AutovalidateMode.always;
      });
    }
  }
}
