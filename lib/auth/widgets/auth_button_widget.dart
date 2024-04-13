import 'package:flutter/material.dart';
import 'package:mobile_p3l/constants.dart';

class AuthButtonWidget extends StatelessWidget {
  final Color? color;
  final Function()? onPressFunc;
  final Widget child;
  const AuthButtonWidget({
    super.key,
    required this.color,
    this.onPressFunc,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressFunc,
      style: ButtonStyle(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        enableFeedback: false,
        overlayColor: MaterialStatePropertyAll(indigo[600]),
        splashFactory: NoSplash.splashFactory,
        backgroundColor: MaterialStatePropertyAll(color),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        fixedSize: MaterialStateProperty.all(
          Size(MediaQuery.sizeOf(context).width, 48.0),
        ),
      ),
      child: child,
    );
  }
}

class AuthTextButton extends StatelessWidget {
  final String innerText;
  const AuthTextButton({super.key, required this.innerText});

  @override
  Widget build(BuildContext context) {
    return Text(
      innerText,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        fontFamily: "Poppins",
        color: slate[50],
      ),
    );
  }
}

class AuthCircularIcons extends StatelessWidget {
  const AuthCircularIcons({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 16,
      height: 16,
      padding: const EdgeInsets.all(2.0),
      child: const CircularProgressIndicator(
        color: Colors.white,
        strokeWidth: 3,
      ),
    );
  }
}
