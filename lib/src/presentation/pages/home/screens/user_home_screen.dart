import 'package:flutter/material.dart';
import 'package:mobile_p3l/src/utils/constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 100.w,
        height: 100.h,
        color: Colors.green,
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              logout();
              Navigator.of(context).pushNamedAndRemoveUntil("/auth/login", (route) => false);
            },
            child: const Text("Logout")
          )
        ),
      ),
    );
  }
}
