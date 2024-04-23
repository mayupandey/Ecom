import 'package:ecom/src/common_widget/password_reset.dart';
import 'package:ecom/src/feature/authentication/presentation/login_screen.dart';
import 'package:ecom/src/feature/authentication/presentation/signup_screen.dart';
import 'package:ecom/src/feature/authentication/service/authentication_check.dart';
import 'package:ecom/src/feature/home/model/product_list_modal.dart';
import 'package:ecom/src/feature/home/presentation/home_details.dart';

import 'package:go_router/go_router.dart';

import 'Routes.dart';

final goRouter = GoRouter(
    initialLocation: "/${Routes.authCheck}",
    debugLogDiagnostics: true,
    routes: [
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
      GoRoute(
        path: '/${Routes.productDetails}',
        name: Routes.productDetails,
        builder: (context, state) {
          Products product = state.extra! as Products;
          return ProductDetails(
            product: product,
          );
        },
      ),
      GoRoute(
          path: '/${Routes.passwordReset}',
          name: Routes.passwordReset,
          builder: (context, state) => const PasswordResetForm())
    ]);
