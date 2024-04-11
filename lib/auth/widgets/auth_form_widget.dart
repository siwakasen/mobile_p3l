import 'package:flutter/material.dart';
import 'package:mobile_p3l/constants.dart';

class AuthFormWidget extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?) validator;
  final String hintText;
  final IconData icons;
  TextInputType type;
  AuthFormWidget({
    Key? key,
    required this.controller,
    required this.validator,
    required this.hintText,
    required this.icons,
    this.type = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      textAlignVertical: TextAlignVertical.bottom,
      controller: controller,
      keyboardType: type,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        prefixIcon: Icon(
          icons,
          color: slate[400],
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          fontFamily: "Poppins",
          fontWeight: FontWeight.normal,
          fontSize: 14,
          color: slate[400],
        ),
        errorStyle: const TextStyle(
          fontFamily: "Poppins",
          fontWeight: FontWeight.normal,
          fontSize: 10,
          color: Colors.red,
        ),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: slate[300]!),
          borderRadius: BorderRadius.circular(12),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
