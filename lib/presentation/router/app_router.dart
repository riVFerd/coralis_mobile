import 'package:coralis_test/presentation/screens/auth/login_screen.dart';
import 'package:coralis_test/presentation/screens/auth/register_screen.dart';
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
      )
    ],
  );
}
