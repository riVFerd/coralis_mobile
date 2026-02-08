import 'package:coralis_test/common/extensions/context_extension.dart';
import 'package:coralis_test/common/extensions/widget_extension.dart';
import 'package:coralis_test/data/repositories/auth_repository.dart';
import 'package:coralis_test/injection.dart';
import 'package:coralis_test/presentation/components/custom_button.dart';
import 'package:coralis_test/presentation/components/custom_text_field.dart';
import 'package:coralis_test/presentation/components/loading.dart';
import 'package:coralis_test/presentation/screens/auth/login_screen.dart';
import 'package:coralis_test/presentation/themes/color_theme.dart';
import 'package:coralis_test/presentation/themes/sizing.dart';
import 'package:coralis_test/presentation/themes/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';

class ResetPasswordScreen extends HookWidget {
  final String resetToken;

  const ResetPasswordScreen({super.key, required this.resetToken});

  static const path = "/reset-password";

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isLoading = useState(false);

    void submitHandler() async {
      try {
        isLoading.value = true;
        if (formKey.currentState?.saveAndValidate() ?? false) {
          final newPassword =
              formKey.currentState!.value['new_password'] as String;
          final res = await get<AuthRepository>()
              .resetPassword(resetToken, newPassword);

          res.fold(
            (l) => context.showSnackBar(l.message),
            (r) {
              context.showSnackBar(r);
              context.go(LoginScreen.path);
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
                  "Reset Password",
                  style: TS.displayLarge,
                ),
                Sz.vSpacingSmall,
                Text(
                  "Enter your new password below.",
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
                          name: 'new_password',
                          label: 'New Password',
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
                          label: 'Confirm New Password',
                          hintText: '••••••••',
                          isPassword: true,
                          prefixIcon: const Icon(Icons.lock_outline),
                          textInputAction: TextInputAction.done,
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return 'This field cannot be empty.';
                            }
                            if (formKey
                                    .currentState?.fields['new_password']?.value !=
                                val) {
                              return 'Passwords do not match.';
                            }
                            return null;
                          },
                        ),
                        Sz.vSpacingMediumLarge,
                        CustomButton(
                          text: "Reset Password",
                          onPressed: submitHandler,
                          isLoading: isLoading.value,
                        ),
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
