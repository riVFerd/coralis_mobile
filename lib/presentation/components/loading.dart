import 'package:coralis_test/common/extensions/context_extension.dart';
import 'package:coralis_test/presentation/themes/color_theme.dart';
import 'package:flutter/material.dart';

class CenterLoadingOverlay extends StatelessWidget {
  const CenterLoadingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      height: context.height,
      color: Colors.grey.withOpacity(0.5),
      child: const Center(
        child: CircularProgressIndicator(
          color: CT.primaryBlue,
        ),
      ),
    );
  }
}