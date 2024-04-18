import 'package:flutter/material.dart';
import 'package:mobile_p3l/auth/screens/login_screen.dart';
import 'package:mobile_p3l/constants.dart';
import 'package:mobile_p3l/routes/app_route.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (contex, orientation, screenType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppRoute.generateRoute,
          initialRoute: AppRoute.login,
          theme: ThemeData(
            colorScheme: const ColorScheme.light(
              background:Colors.white
            )
          ),
        );
      },
    );
  }
}
