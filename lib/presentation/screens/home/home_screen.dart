import 'package:coralis_test/data/models/user_model.dart';
import 'package:coralis_test/presentation/screens/auth/login_screen.dart';
import 'package:coralis_test/presentation/themes/color_theme.dart';
import 'package:coralis_test/presentation/themes/sizing.dart';
import 'package:coralis_test/presentation/themes/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.user});

  final UserModel user;

  static const path = "/home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CT.background,
      appBar: AppBar(
        title: Text("Home", style: TS.textLarge),
        backgroundColor: CT.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded, color: CT.primaryBlue),
            onPressed: () => context.go(LoginScreen.path),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: Sz.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // User Card
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: CT.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: CT.primaryBlue.withAlpha(20),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: CT.primaryBlue,
                    child: Icon(Icons.person_rounded, size: 40, color: CT.white),
                  ),
                  Sz.vSpacingMedium,
                  Text(
                    "Welcome back,",
                    style: TS.textSmall,
                  ),
                  Text(
                    user.name,
                    style: TS.displayMedium.copyWith(color: CT.primaryDark),
                    textAlign: TextAlign.center,
                  ),
                  Sz.vSpacingSmall,
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: CT.background,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.email_outlined,
                            size: 16, color: CT.textSecondary),
                        Sz.hSpacingSmall,
                        Text(
                          user.email,
                          style: TS.textSmall.copyWith(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
