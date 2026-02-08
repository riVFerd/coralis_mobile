import 'package:coralis_test/data/models/user_model.dart';
import 'package:coralis_test/presentation/screens/auth/login_screen.dart';
import 'package:coralis_test/presentation/screens/auth/register_screen.dart';
import 'package:coralis_test/presentation/screens/auth/forgot_password_screen.dart';
import 'package:coralis_test/presentation/screens/auth/reset_password_screen.dart';
import 'package:coralis_test/presentation/screens/home/home_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {


  static final router = GoRouter(
    initialLocation: LoginScreen.path,
    routes: [
      GoRoute(
        path: LoginScreen.path,
        builder: (_, __) => const LoginScreen(),
      ),
      GoRoute(
        path: RegisterScreen.path,
        builder: (_, __) => const RegisterScreen(),
      ),
      GoRoute(
        path: HomeScreen.path,
        builder: (_, state) {
          final user = state.extra as UserModel;
          return HomeScreen(user: user);
        },
      ),
      GoRoute(
        path: ForgotPasswordScreen.path,
        builder: (_, __) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: ResetPasswordScreen.path,
        builder: (_, state) {
          final resetToken = state.extra as String;
          return ResetPasswordScreen(resetToken: resetToken);
        },
      ),
    ],
  );
}
