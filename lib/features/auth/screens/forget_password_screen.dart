import 'package:auto_route/auto_route.dart';
import 'package:e_fashion_flutter/config/router/app_router.dart';
import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/core/utils/show_toast.dart';
import 'package:e_fashion_flutter/core/widgets/custom_text_form_field.dart';
import 'package:e_fashion_flutter/core/widgets/primary_button.dart';
import 'package:e_fashion_flutter/features/auth/cubit/auth_cubit.dart';
import 'package:e_fashion_flutter/features/auth/cubit/auth_state.dart';
import 'package:e_fashion_flutter/features/auth/screens/widgets/auth_background_image_and_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

@RoutePage()
class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  late String email;
  late GlobalKey<FormState> _formKey;
  late AutovalidateMode _autovalidateMode;

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
        child: Form(
          key: _formKey,
          autovalidateMode: _autovalidateMode,
          child: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Forget Password",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    "Enter the email address associated \n with your account",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 40.0),
                  CustomTextFormField(
                    type: TextInputType.emailAddress,
                    autofillHints: const [AutofillHints.email],
                    textInputAction: TextInputAction.done,
                    hintText: "Email",
                    label: "Email",
                    prefixIcon: Icon(
                      FontAwesomeIcons.envelope,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
                    ),
                    onSaved: (value) {
                      email = value!;
                    },
                    onSubmit: (_) async {
                      await _onSubmit();
                    },
                  ),
                  const SizedBox(height: 75.0),
                  BlocConsumer<AuthCubit, AuthState>(
                    buildWhen:
                        (previous, current) =>
                            previous.forgetPasswordRequestStatus !=
                            current.forgetPasswordRequestStatus,
                    listenWhen:
                        (previous, current) =>
                            previous.forgetPasswordRequestStatus !=
                            current.forgetPasswordRequestStatus,
                    listener: (context, state) {
                      if (state.forgetPasswordRequestStatus.isSuccess) {
                        showToast(
                          message: state.authResponseModel.message,
                          state: ToastStates.success,
                        );
                        context.navigateTo(
                          EmailVerificationRoute(email: email.trim()),
                        );
                      }
                      if (state.forgetPasswordRequestStatus.isError) {
                        showToast(
                          message: state.authErrorMessage,
                          state: ToastStates.error,
                        );
                      }
                    },
                    builder: (context, state) {
                      return PrimaryButton(
                        isLoading: state.forgetPasswordRequestStatus.isLoading,
                        onPressed: () async {
                          await _onSubmit();
                        },
                        text: "Recover password",
                      );
                    },
                  ),
                  const SizedBox(height: 40.0),
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
      context.read<AuthCubit>().forgetPassword(email: email);
    } else {
      setState(() {
        _autovalidateMode = AutovalidateMode.always;
      });
    }
  }
}
