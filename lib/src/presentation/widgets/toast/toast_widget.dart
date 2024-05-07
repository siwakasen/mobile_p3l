import 'package:flutter/material.dart';
import 'package:mobile_p3l/src/utils/constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:toastification/toastification.dart';

ToastificationItem toast(
    BuildContext context, String message, ToastificationType type) {
  return toastification.show(
    context: context,
    type: type,
    title: Text(
      message,
      style: TextStyle(
        fontFamily: "Poppins",
        fontWeight: FontWeight.normal,
        color: slate[600],
        fontSize: 14.sp,
      ),
    ),
    autoCloseDuration: const Duration(seconds: 3),
    alignment: Alignment.bottomCenter,
    showProgressBar: false,
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        spreadRadius: -2.0,
        blurRadius: 5,
        blurStyle: BlurStyle.outer,
        offset: const Offset(0, 2),
      ),
    ],
  );
}
