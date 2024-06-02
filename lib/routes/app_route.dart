import 'package:flutter/material.dart';
import 'package:mobile_p3l/src/presentation/pages/auth/screens/login_screen.dart';
import 'package:mobile_p3l/src/presentation/pages/detail/detail_hampers.dart';
import 'package:mobile_p3l/src/presentation/pages/detail/detail_produk.dart';
import 'package:mobile_p3l/src/presentation/pages/home/buttom_navbar.dart';
import 'package:mobile_p3l/src/presentation/pages/home/screens/email_verification%20_screen.dart';
import 'package:mobile_p3l/src/presentation/pages/home/screens/mo_home_screen.dart';
import 'package:mobile_p3l/src/presentation/pages/home/screens/user_home_screen.dart';
import 'package:mobile_p3l/src/presentation/pages/landing/home_landing.dart';
import 'package:mobile_p3l/src/presentation/pages/profile/screens/change_password_screen.dart';
import 'package:mobile_p3l/src/presentation/pages/profile/screens/order_history_screen.dart';
import 'package:mobile_p3l/src/presentation/pages/profile/screens/personal_information_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:mobile_p3l/src/presentation/pages/informasi_umum/informasi_umum.dart';
import 'package:mobile_p3l/src/presentation/pages/profile/screens/balance_history_screen.dart';

class AppRoute {
  static const String login = "/auth/signin";
  static const String dashboard = "/dashboard";
  static const String homeUser = '/home/user';
  static const String homeMo = '/home/mo';
  static const String personalInformation = '/personal-information';
  static const String orderHistory = '/order-history';
  static const String forgetPassword = '/forget-password';
  static const String changePassword = '/change-password';
  static const String homeLanding = '/guest/landing';
  static const String detailProduk = '/detail/produk';
  static const String detailHampers = '/detail/hampers';
  static const String informasiToko = '/informasi-toko';
  static const String historiSaldo = '/histori-saldo';
  static Route<dynamic>? generateRoute(RouteSettings settings,
      {Object? arguments}) {
    switch (settings.name) {
      case login:
        return PageTransition(
            child: const LoginScreen(),
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 400));
      case informasiToko:
        return PageTransition(
            child: const InformasiUmum(),
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 400));
      case historiSaldo:
        return PageTransition(
            child: const BalanceHistoryScreen(),
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
      case personalInformation:
        return PageTransition(
            child: const PersonalInformationScreen(),
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
      case orderHistory:
        return PageTransition(
            child: const OrderHistoryScreen(),
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 400));
      case homeLanding:
        return PageTransition(
            child: const HomeLanding(),
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 400));
      case detailProduk:
        return PageTransition(
            child: const DetailProduk(),
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 400));
      case detailHampers:
        return PageTransition(
            child: const DetailHampers(),
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
