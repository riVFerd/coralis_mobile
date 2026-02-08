import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color_theme.dart';

class TextStyles {
  static final displayLarge = GoogleFonts.poppins(
    color: CT.primaryBlue,
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 1.2,
  );

  static final displayMedium = GoogleFonts.poppins(
    color: CT.textPrimary,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );

  static final textLarge = GoogleFonts.montserrat(
    color: CT.textPrimary,
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static final textMedium = GoogleFonts.montserrat(
    color: CT.textPrimary,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static final textSmall = GoogleFonts.montserrat(
    color: CT.textSecondary,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static final buttonText = GoogleFonts.montserrat(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.5,
  );
}

/// Alias for [TextStyles]
typedef TS = TextStyles;