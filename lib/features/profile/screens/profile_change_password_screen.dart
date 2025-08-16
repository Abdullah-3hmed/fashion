import 'package:auto_route/auto_route.dart';
import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/core/utils/show_toast.dart';
import 'package:e_fashion_flutter/core/utils/toast_states.dart';
import 'package:e_fashion_flutter/core/widgets/password_filed.dart';
import 'package:e_fashion_flutter/core/widgets/primary_button.dart';
import 'package:e_fashion_flutter/core/widgets/secondary_button.dart';
import 'package:e_fashion_flutter/features/profile/cubit/user_cubit/user_cubit.dart';
import 'package:e_fashion_flutter/features/profile/cubit/user_cubit/user_state.dart';
import 'package:e_fashion_flutter/features/profile/screens/widgets/profile_background_image_and_logo.dart';
import 'package:e_fashion_flutter/features/profile/screens/widgets/profile_clipped_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          isClipped: true,
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
                      textInputAction: TextInputAction.next,
                      hintText: "old password",
                      label: "old password",
                    ),
                    const SizedBox(height: 16.0),
                    PasswordField(
                      onSaved: (value) {
                        newPassword = value!;
                      },
                      textInputAction: TextInputAction.next,
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
                      child: BlocConsumer<UserCubit, UserState>(
                        listenWhen:
                            (previous, current) =>
                                previous.changePasswordRequestStatus !=
                                current.changePasswordRequestStatus,
                        buildWhen:
                            (previous, current) =>
                                previous.changePasswordRequestStatus !=
                                current.changePasswordRequestStatus,
                        listener: (context, state) async {
                          if (state.changePasswordRequestStatus.isSuccess) {
                            context.pop();
                            await showToast(
                              message: state.changePasswordMessage,
                              state: ToastStates.success,
                            );
                          }
                          if (state.changePasswordRequestStatus.isError) {
                            await showToast(
                              message: state.changePasswordMessage,
                              state: ToastStates.error,
                            );
                          }
                        },
                        builder: (context, state) {
                          return PrimaryButton(
                            isLoading:
                                state.changePasswordRequestStatus.isLoading,
                            onPressed: () async {
                              await _onPressed();
                            },
                            text: "done",
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 60.0),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onPressed() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await context.read<UserCubit>().changePassword(
        currentPassword: oldPassword,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );
    } else {
      setState(() {
        _autovalidateMode = AutovalidateMode.always;
      });
    }
    TextInput.finishAutofillContext();
  }
}
