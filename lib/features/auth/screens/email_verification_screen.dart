import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:e_fashion_flutter/config/router/app_router.dart';
import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/core/utils/show_toast.dart';
import 'package:e_fashion_flutter/core/utils/toast_states.dart';
import 'package:e_fashion_flutter/core/widgets/primary_button.dart';
import 'package:e_fashion_flutter/features/auth/cubit/auth_cubit.dart';
import 'package:e_fashion_flutter/features/auth/cubit/auth_state.dart';
import 'package:e_fashion_flutter/features/auth/screens/widgets/auth_background_image_and_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

@RoutePage()
class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  late final GlobalKey<FormState> _formKey;
  late final AutovalidateMode _autovalidateMode;
  String otp = "";
  bool isOtpError = false;

  late Timer _timer;
  int _secondsRemaining = 59;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _autovalidateMode = AutovalidateMode.disabled;
    _startTimer();
  }

  void _startTimer() {
    _secondsRemaining = 59;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining == 0) {
        timer.cancel();
      } else {
        setState(() {
          _secondsRemaining--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String expectedOtp = context.select(
      (AuthCubit cubit) => cubit.state.passwordModel.otp.toString(),
    );
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
                      if (value != expectedOtp) {
                        setState(() {
                          isOtpError = true;
                          showToast(
                            message: "Error! wrong otp code",
                            state: ToastStates.error,
                          );
                        });
                      } else {
                        setState(() {
                          otp = value;
                          isOtpError = false;
                        });
                        context.navigateTo(const ResetPasswordRoute());
                        await context.read<AuthCubit>().resetPasswordOtpVerify(
                          otp: otp,
                        );
                      }
                    },
                    defaultPinTheme: PinTheme(
                      width: 40.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color:
                              isOtpError
                                  ? Theme.of(context).colorScheme.error
                                  : Theme.of(context).colorScheme.outline,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 70.0),
                  BlocConsumer<AuthCubit, AuthState>(
                    buildWhen:
                        (previous, current) =>
                            previous.emailVerificationRequestStatus !=
                            current.emailVerificationRequestStatus,
                    listenWhen:
                        (previous, current) =>
                            previous.emailVerificationRequestStatus !=
                            current.emailVerificationRequestStatus,
                    listener: (context, state) {
                      if (state.emailVerificationRequestStatus ==
                          RequestStatus.error) {
                        showToast(
                          message: state.emailVerificationErrorMessage,
                          state: ToastStates.error,
                        );
                      }
                    },
                    builder: (context, state) {
                      return _secondsRemaining > 0
                          ? Text(
                            "RESEND OTP IN 00:${_secondsRemaining.toString().padLeft(2, '0')}",
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          )
                          : PrimaryButton(
                            isLoading:
                                state.emailVerificationRequestStatus ==
                                RequestStatus.loading,
                            onPressed: () async {
                              await _onSubmit();
                            },
                            text: "Resend OTP",
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
      //TODO: apply resend otp when it is completed

      // await context.read<AuthCubit>().resetPasswordOtpVerify(otp: otp);
    } else {
      setState(() {
        _autovalidateMode = AutovalidateMode.always;
      });
    }
  }
}
