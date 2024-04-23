import 'package:ecom/src/feature/authentication/presentation/login_screen.dart';
import 'package:ecom/src/feature/authentication/presentation/signup_screen.dart';
import 'package:ecom/src/feature/authentication/service/authentication_check.dart';
import 'package:ecom/src/feature/intro/intro_screen.dart';
import 'package:go_router/go_router.dart';

import 'Routes.dart';

final goRouter = GoRouter(
    initialLocation: "/${Routes.authCheck}",
    debugLogDiagnostics: true,
    routes: [
      GoRoute(path: '/', builder: (context, state) => const IntroScreen()),
      GoRoute(
          path: "/${Routes.login}",
          name: Routes.login,
          builder: (context, state) => const LoginScreen()),
      GoRoute(
          path: "/${Routes.signUp}",
          name: Routes.signUp,
          builder: (context, state) => const SignUpScreen()),
      GoRoute(
          path: "/${Routes.authCheck}",
          name: Routes.authCheck,
          builder: (context, state) => const AuthenticationCheck()),
    ]);
