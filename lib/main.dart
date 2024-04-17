import 'package:flutter/material.dart';
import 'package:mobile_p3l/constants.dart';
import 'package:mobile_p3l/routes/app_route.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  String? token;

  void getLoginData() async {
    String? checkToken = await loadPreference('token');
    setState(() => token = checkToken);
  }

  @override
  void initState() {
    getLoginData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (contex, orientation, screenType) {
        return MaterialApp(
          onGenerateRoute: AppRoute.generateRoute,
          initialRoute: AppRoute.login,
          // home: token == null ? const LoginScreen() : const Dashboard(),
        );
      },
    );
  }
}
