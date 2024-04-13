import 'package:flutter/material.dart';
import 'package:mobile_p3l/auth/screens/login_screen.dart';
import 'package:mobile_p3l/home/buttom_navbar.dart';
import 'package:mobile_p3l/home/screens/user_home_screen.dart';
import 'package:page_transition/page_transition.dart';

class AppRoute {
  static const String login = "/auth/signin";
  static const String dashboard = "/dashboard";
  static const String homeUser = '/home/user';

  static Route<dynamic>? generateRoute(RouteSettings settings,
      {Object? arguments}) {
    switch (settings.name) {
      case login:
        return PageTransition(
            child: const LoginScreen(),
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 400));
      case homeUser:
        return PageTransition(
            child: const UserHomeScreen(),
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 400));
      case dashboard:
        return PageTransition(
            child: ButtomNavigation(
              index: settings.arguments as int,
            ),
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 400));
      default:
        return PageTransition(
            child: const LoginScreen(),
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 400));
    }
  }
}
