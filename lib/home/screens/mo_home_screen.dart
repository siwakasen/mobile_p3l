import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MOHomeScreen extends StatefulWidget {
  const MOHomeScreen({super.key});

  @override
  State<MOHomeScreen> createState() => _MOHomeScreenState();
}

class _MOHomeScreenState extends State<MOHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 100.w,
        height: 100.h,
        color: Colors.red,
        child: Center(
          child: ElevatedButton(
              onPressed: () => Navigator.of(context).pushNamed("/auth/signin"),
              child: const Text("Test push to Login")),
        ),
      ),
    );
  }
}
