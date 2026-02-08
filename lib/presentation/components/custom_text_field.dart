import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../themes/color_theme.dart';
import '../themes/text_styles.dart';

class CustomTextField extends HookWidget {
  final String name;
  final String label;
  final String? hintText;
  final bool isPassword;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Widget? prefixIcon;

  const CustomTextField({
    super.key,
    required this.name,
    required this.label,
    this.hintText,
    this.isPassword = false,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final isObscure = useState(isPassword);
    final focusNode = useFocusNode();
    final isFocused = useState(false);

    useEffect(() {
      focusNode.addListener(() {
        isFocused.value = focusNode.hasFocus;
      });
      return null;
    }, [focusNode]);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TS.textMedium.copyWith(
            fontWeight: FontWeight.w600,
            color: CT.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        FormBuilderTextField(
          name: name,
          focusNode: focusNode,
          validator: validator,
          obscureText: isObscure.value,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          style: TS.textMedium.copyWith(color: CT.textPrimary),
          decoration: InputDecoration(
            hintText: hintText,
            errorMaxLines: 2,
            hintStyle: TS.textMedium.copyWith(color: CT.darkGrey),
            filled: true,
            fillColor: isFocused.value ? CT.white : CT.background,
            prefixIcon: prefixIcon != null
                ? IconTheme(
                    data: IconThemeData(
                      color: isFocused.value ? CT.primaryBlue : CT.darkGrey,
                    ),
                    child: prefixIcon!,
                  )
                : null,
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      isObscure.value ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                      color: isFocused.value ? CT.primaryBlue : CT.darkGrey,
                    ),
                    onPressed: () => isObscure.value = !isObscure.value,
                  )
                : null,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none, // Transparent border when enabled but not focused if preferred, or maintain gentle border
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: CT.primaryBlue, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}
