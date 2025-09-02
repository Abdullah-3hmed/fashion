import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:e_fashion_flutter/config/router/app_router.dart';
import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/core/utils/show_toast.dart';
import 'package:e_fashion_flutter/core/widgets/primary_button.dart';
import 'package:e_fashion_flutter/features/auth/cubit/auth_cubit.dart';
import 'package:e_fashion_flutter/features/auth/cubit/auth_state.dart';
import 'package:e_fashion_flutter/features/auth/screens/widgets/auth_background_image_and_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

@RoutePage()
class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key, required this.email});
  final String email;

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  late final GlobalKey<FormState> _formKey;
  late final AutovalidateMode _autovalidateMode;
  late final ValueNotifier<int> _secondsRemaining;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _autovalidateMode = AutovalidateMode.disabled;
    _secondsRemaining = ValueNotifier<int>(59);
    _startTimer();
  }

  void _startTimer() {
    _secondsRemaining.value = 59;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining.value == 0) {
        timer.cancel();
      } else {
        _secondsRemaining.value--;
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _secondsRemaining.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackgroundImageAndLogo(
        height: 540.0,
        child: Center(
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Form(
              key: _formKey,
              autovalidateMode: _autovalidateMode,
              child: Column(
                children: [
                  Text(
                    "Email verification",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    "Enter the 6 digit code sent \n to your email address",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 46.0),
                  Pinput(
                    length: 6,
                    onCompleted: (value) async {
                      await context
                          .read<AuthCubit>()
                          .verifyOtp(email: widget.email, otp: value);
                    },
                    defaultPinTheme: PinTheme(
                      width: 40.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 70.0),
                  BlocConsumer<AuthCubit, AuthState>(
                    buildWhen: (previous, current) =>
                    previous.forgetPasswordRequestStatus !=
                        current.forgetPasswordRequestStatus,
                    listenWhen: (previous, current) =>
                    previous.verifyOtpRequestStatus !=
                        current.verifyOtpRequestStatus,
                    listener: (context, state) {
                      if (state.verifyOtpRequestStatus.isError) {
                        showToast(
                          message: state.verifyOtpErrorMessage,
                          state: ToastStates.error,
                        );
                      }
                      if (state.verifyOtpRequestStatus.isSuccess) {
                        showToast(
                          message: state.verifyOtpMessage,
                          state: ToastStates.success,
                        );
                        context.navigateTo( ResetPasswordRoute(
                          email: widget.email,
                        ));
                      }
                    },
                    builder: (context, state) {
                      return ValueListenableBuilder<int>(
                        valueListenable: _secondsRemaining,
                        builder: (context, value, _) {
                          return value > 0
                              ? Text(
                            "RESEND OTP IN 00:${value.toString().padLeft(2, '0')}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary,
                            ),
                          )
                              : PrimaryButton(
                            isLoading: state
                                .forgetPasswordRequestStatus.isLoading,
                            onPressed: () async {
                              await _onSubmit();
                              _startTimer();
                            },
                            text: "Resend OTP",
                          );
                        },
                      );
                    },
                  ),
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

      await context.read<AuthCubit>().forgetPassword(email: widget.email);
    } else {
      setState(() {
        _autovalidateMode = AutovalidateMode.always;
      });
    }
  }
}
