import 'package:flutter/material.dart';
// import 'package:moe_cfims/presentation/auth/login/login_screen.dart';
import 'package:moe_cfims/presentation/core/screen_transitions/fade_transition_route.dart';
import 'package:moe_cfims/presentation/core/screen_transitions/slide_transition_route.dart';
import 'package:moe_cfims/presentation/Screen/splash/splash_page.dart';
import 'package:moe_cfims/presentation/Screen/Login/login_screen.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashPage.routeName:
        return FadeTransitionRoute(
          page: SplashPage(),
        );

      case LoginScreen.routeName:
        return SlideTransitionRoute(
          page: LoginScreen(),
        );

      // case HomeScreen.routeName:
      //   return FadeTransitionRoute(
      //     page: HomeScreen(),
      //   );

      default:
        return FadeTransitionRoute(
          page: SplashPage(),
        );
    }
  }
}
