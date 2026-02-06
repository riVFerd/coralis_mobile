import 'package:coralis_test/common/extensions/context_extension.dart';
import 'package:coralis_test/presentation/components/custom_button.dart';
import 'package:coralis_test/presentation/components/custom_text_field.dart';
import 'package:coralis_test/presentation/themes/color_theme.dart';
import 'package:coralis_test/presentation/themes/sizing.dart';
import 'package:coralis_test/presentation/themes/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends HookWidget {
  const RegisterScreen({super.key});

  static const path = "/register";

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());

    return Scaffold(
      backgroundColor: CT.background,
      body: SingleChildScrollView(
        child: Container(
          padding: Sz.screenPadding,
          child: Column(
            children: [
              Sz.vSpacingMediumLarge,
              Text(
                "Coralis Studio",
                style: TS.displayLarge,
              ),

              Sz.vSpacingMediumLarge,

              // Register Card
              Container(
                decoration: BoxDecoration(
                  color: CT.white,
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: CT.primaryBlue.withAlpha(20),
                      blurRadius: 24,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(32),
                child: FormBuilder(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Create Account",
                        style: TS.displayMedium,
                        textAlign: TextAlign.center,
                      ),
                      Sz.vSpacingSmall,
                      Text(
                        "Sign up to get started",
                        style: TS.textSmall,
                        textAlign: TextAlign.center,
                      ),
                      Sz.vSpacingLarge,

                      CustomTextField(
                        name: 'name',
                        label: 'Full Name',
                        hintText: 'John Doe',
                        prefixIcon: const Icon(Icons.person_outline_rounded),
                        textInputAction: TextInputAction.next,
                        validator: FormBuilderValidators.required(),
                      ),
                      Sz.vSpacingMedium,

                      CustomTextField(
                        name: 'email',
                        label: 'Email Address',
                        hintText: 'hello@example.com',
                        prefixIcon: const Icon(Icons.email_outlined),
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.email(),
                        ]),
                      ),
                      Sz.vSpacingMedium,

                      CustomTextField(
                        name: 'password',
                        label: 'Password',
                        hintText: '••••••••',
                        isPassword: true,
                        prefixIcon: const Icon(Icons.lock_outline_rounded),
                        textInputAction: TextInputAction.next,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.minLength(6),
                        ]),
                      ),
                      Sz.vSpacingMedium,

                      CustomTextField(
                        name: 'confirm_password',
                        label: 'Confirm Password',
                        hintText: '••••••••',
                        isPassword: true,
                        prefixIcon: const Icon(Icons.lock_outline),
                        textInputAction: TextInputAction.done,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'This field cannot be empty.';
                          }
                          if (formKey.currentState?.fields['password']?.value != val) {
                            return 'Passwords do not match.';
                          }
                          return null;
                        },
                      ),

                      Sz.vSpacingMediumLarge,

                      CustomButton(
                        text: "Register",
                        onPressed: () {
                          if (formKey.currentState?.saveAndValidate() ?? false) {
                            // Handle registration
                            // logger.d(formKey.currentState?.value);
                          }
                        },
                      ),

                      Sz.vSpacingMedium,

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?",
                            style: TS.textSmall,
                          ),
                          TextButton(
                            onPressed: () => context.pop(),
                            style: TextButton.styleFrom(
                              foregroundColor: CT.primaryBlue,
                              textStyle: TS.textSmall.copyWith(fontWeight: FontWeight.bold),
                            ),
                            child: const Text("Login"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
