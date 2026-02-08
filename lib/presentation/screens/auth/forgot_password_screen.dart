import 'package:coralis_test/common/extensions/context_extension.dart';
import 'package:coralis_test/common/extensions/widget_extension.dart';
import 'package:coralis_test/data/repositories/auth_repository.dart';
import 'package:coralis_test/injection.dart';
import 'package:coralis_test/presentation/components/custom_button.dart';
import 'package:coralis_test/presentation/components/custom_text_field.dart';
import 'package:coralis_test/presentation/components/loading.dart';
import 'package:coralis_test/presentation/screens/auth/reset_password_screen.dart';
import 'package:coralis_test/presentation/themes/color_theme.dart';
import 'package:coralis_test/presentation/themes/sizing.dart';
import 'package:coralis_test/presentation/themes/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordScreen extends HookWidget {
  const ForgotPasswordScreen({super.key});

  static const path = "/forgot-password";

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isLoading = useState(false);
    final resetToken = useState<String?>(null);

    void submitHandler() async {
      try {
        isLoading.value = true;
        resetToken.value = null; // Reset previous token
        if (formKey.currentState?.saveAndValidate() ?? false) {
          final email = formKey.currentState!.value['email'] as String;
          final res = await get<AuthRepository>().forgotPassword(email);

          res.fold(
            (l) {
              context.showSnackBar(l.message);
            },
            (r) {
              context.showSnackBar("Reset token generated successfully");
              resetToken.value = r;
            },
          );
        }
      } finally {
        isLoading.value = false;
      }
    }

    return Scaffold(
      backgroundColor: CT.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: Sz.screenPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Sz.vSpacingMediumLarge,
                Text(
                  "Forgot Password",
                  style: TS.displayLarge,
                ),
                Sz.vSpacingSmall,
                Text(
                  "Enter your email address to reset your password.",
                  style: TS.textMedium.copyWith(color: CT.darkGrey),
                ),
                Sz.vSpacingLarge,
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
                        CustomTextField(
                          name: 'email',
                          label: 'Email Address',
                          hintText: 'hello@example.com',
                          prefixIcon: const Icon(Icons.email_outlined),
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.done,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.email(),
                          ]),
                        ),
                        Sz.vSpacingMediumLarge,
                        CustomButton(
                          text: "Send Reset Link",
                          onPressed: submitHandler,
                          isLoading: isLoading.value,
                        ),
                        if (resetToken.value != null) ...[
                          Sz.vSpacingMedium,
                          CustomButton(
                            text: "Proceed to Reset Password",
                            onPressed: () {
                              context.push(
                                ResetPasswordScreen.path,
                                extra: resetToken.value,
                              );
                            },
                            isOutlined: true,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
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
