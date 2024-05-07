import 'package:flutter/material.dart';
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
              onPressed: () => Navigator.of(context).pushNamed("/home/mo"),
              child: const Text("Test push to Mo")),
        ),
      ),
    );
  }
}
