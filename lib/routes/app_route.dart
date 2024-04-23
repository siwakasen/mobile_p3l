import 'package:flutter/material.dart';
import 'package:mobile_p3l/auth/screens/login_screen.dart';
import 'package:mobile_p3l/home/buttom_navbar.dart';
import 'package:mobile_p3l/home/screens/email_verification%20_screen.dart';
import 'package:mobile_p3l/home/screens/mo_home_screen.dart';
import 'package:mobile_p3l/home/screens/user_home_screen.dart';
import 'package:mobile_p3l/profile/screens/change_password_screen.dart';
import 'package:page_transition/page_transition.dart';

class AppRoute {
  static const String login = "/auth/signin";
  static const String dashboard = "/dashboard";
  static const String homeUser = '/home/user';
  static const String homeMo = '/home/mo';
  static const String forgetPassword = '/forget-password';
  static const String changePassword = '/change-password';

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
      case homeMo:
        return PageTransition(
            child: const MOHomeScreen(),
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 400));
      case dashboard:
        return PageTransition(
            child: Dashboard(
              index: settings.arguments as int,
            ),
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 400));
      case forgetPassword:
        return PageTransition(
            child: const EmailVerificationScreen(),
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 400));
      case changePassword:
        return PageTransition(
            child: ChangePasswordScreen(
              email: settings.arguments as String,
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
