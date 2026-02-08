import 'package:coralis_test/common/extensions/context_extension.dart';
import 'package:coralis_test/common/extensions/widget_extension.dart';
import 'package:coralis_test/data/repositories/auth_repository.dart';
import 'package:coralis_test/injection.dart';
import 'package:coralis_test/presentation/components/custom_button.dart';
import 'package:coralis_test/presentation/components/custom_text_field.dart';
import 'package:coralis_test/presentation/components/loading.dart';
import 'package:coralis_test/presentation/screens/auth/register_screen.dart';
import 'package:coralis_test/presentation/screens/auth/forgot_password_screen.dart';
import 'package:coralis_test/presentation/screens/home/home_screen.dart';

import 'package:coralis_test/presentation/themes/color_theme.dart';
import 'package:coralis_test/presentation/themes/sizing.dart';
import 'package:coralis_test/presentation/themes/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';

import '../../../data/models/user_model.dart';

class LoginScreen extends HookWidget {
  const LoginScreen({super.key});

  static const path = "/login";

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isLoading = useState(false);

    void loginHandler() async {
      try {
        isLoading.value = true;
        if (formKey.currentState?.saveAndValidate() ?? false) {
          final res = await get<AuthRepository>().login(
            UserModel.loginDTO(
              formKey.currentState!.value,
            ),
          );

          res.fold(
            (l) {
              context.showSnackBar(l.message);

              if (l.errorBag != null) {
                l.errorBag!.forEach((key, value) {
                  formKey.currentState?.fields[key]?.invalidate(value);
                });
              }
            },
            (r) => context.go(
              HomeScreen.path,
              extra: r,
            ),
          );
        }
      } finally {
        isLoading.value = false;
      }
    }

    return Scaffold(
      backgroundColor: CT.background,
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Container(
              height: context.height,
              padding: Sz.screenPadding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Coralis Studio",
                    style: TS.displayLarge,
                  ),

                  // Login Card
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
                            "Welcome Back!",
                            style: TS.displayMedium,
                            textAlign: TextAlign.center,
                          ),
                          Sz.vSpacingSmall,
                          Text(
                            "Please sign in to continue",
                            style: TS.textSmall,
                            textAlign: TextAlign.center,
                          ),
                          Sz.vSpacingLarge,
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
                            textInputAction: TextInputAction.done,
                            validator: FormBuilderValidators.required(),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                context.push(ForgotPasswordScreen.path);
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: CT.primaryBlue,
                                textStyle: TS.textSmall
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                              child: const Text("Forgot Password?"),
                            ),
                          ),
                          Sz.vSpacingMediumLarge,
                          CustomButton(
                            text: "Login",
                            onPressed: loginHandler,
                            isLoading: isLoading.value,
                          ),
                          Sz.vSpacingMedium,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account?",
                                style: TS.textSmall,
                              ),
                              TextButton(
                                onPressed: () =>
                                    context.push(RegisterScreen.path),
                                style: TextButton.styleFrom(
                                  foregroundColor: CT.primaryBlue,
                                  textStyle: TS.textSmall
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                child: const Text("Register"),
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
          const CenterLoadingOverlay().showWhen(
            isLoading.value,
          ),
        ],
      ),
    );
  }
}
