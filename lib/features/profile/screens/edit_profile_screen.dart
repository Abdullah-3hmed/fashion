import 'package:auto_route/auto_route.dart';
import 'package:e_fashion_flutter/core/widgets/custom_text_form_field.dart';
import 'package:e_fashion_flutter/core/widgets/secondary_button.dart';
import 'package:e_fashion_flutter/features/profile/cubit/user_cubit.dart';
import 'package:e_fashion_flutter/features/profile/screens/widgets/profile_background_image_and_logo.dart';
import 'package:e_fashion_flutter/features/profile/screens/widgets/profile_clipped_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solar_icons/solar_icons.dart';

@RoutePage()
class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late GlobalKey<FormState> _formKey;
  late AutovalidateMode _autovalidateMode;
  late TextEditingController _nameController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _autovalidateMode = AutovalidateMode.disabled;
    _nameController = TextEditingController(
      text: context.read<UserCubit>().state.userModel.userName,
    );
    _phoneController = TextEditingController(
      text: context.read<UserCubit>().state.userModel.phone,
    );
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProfileBackgroundImageAndLogo(
        isEditProfileScreen: true,
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
                      "Edit profile",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 70.0),
                    CustomTextFormField(
                      controller: _nameController,
                      type: TextInputType.name,
                      autofillHints: const [AutofillHints.name],
                      hintText: "Edit your name",
                      label: "Edit your name",
                      prefixIcon: const Icon(SolarIconsOutline.user),
                      onSaved: (value) {
                        _nameController.text = value!;
                      },
                      onSubmit: (_) {
                        _onPressed();
                      },
                    ),
                    const SizedBox(height: 16.0),
                    CustomTextFormField(
                      controller: _phoneController,
                      type: TextInputType.phone,
                      autofillHints: const [AutofillHints.telephoneNumber],
                      hintText: "Edit your phone number",
                      label: "Edit your number",
                      textInputAction: TextInputAction.done,
                      prefixIcon: const Icon(SolarIconsOutline.phone),
                      onSaved: (value) {
                        _phoneController.text = value!;
                      },
                      onSubmit: (_) async {
                        await _onPressed();
                      },
                    ),
                    const SizedBox(height: 120.0),
                    Align(
                      child: SecondaryButton(
                        onPressed: () async {
                          await _onPressed();
                        },
                        text: "Done",
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

  Future<void> _onPressed() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      debugPrint('Form is valid');
      await context.read<UserCubit>().editProfile(
        userName: _nameController.text,
        phone: _phoneController.text,
      );
    } else {
      setState(() {
        _autovalidateMode = AutovalidateMode.always;
      });
    }
    TextInput.finishAutofillContext();
  }
}
