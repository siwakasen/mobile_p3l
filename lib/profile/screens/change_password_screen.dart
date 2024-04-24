import 'package:flutter/material.dart';
import 'package:mobile_p3l/auth/widgets/auth_button_widget.dart';
import 'package:mobile_p3l/constants.dart';
import 'package:mobile_p3l/profile/controllers/change_password_controller.dart';
import 'package:mobile_p3l/widgets/toast_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:toastification/toastification.dart';

class ChangePasswordScreen extends StatefulWidget {
  final String? email;
  const ChangePasswordScreen(
      {super.key, this.email}); //email dari lupa password

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  bool isSubmitting = false;
  bool passwordVisible = false;
  bool confirmPasswordVisible = false;
  String? userLoginEmail;
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    getEmail();
    super.initState();
  }

  void getEmail() async {
    if (widget.email != '') {
      //jika email dari lupa password ada maka email diambil dari parameter
      setState(() {
        userLoginEmail = widget.email;
      });
    } else {
      String? getEmail = await loadPreference('email');
      setState(() {
        userLoginEmail = getEmail;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          "Change Password",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins',
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.grey[200],
        centerTitle: true,
        elevation: 0,
        leadingWidth: 22.5.w,
        leading: Row(
          children: [
            SizedBox(width: 4.w),
            Container(
              padding: EdgeInsets.all(2.w),
              child: Container(
                decoration: BoxDecoration(
                  color: indigo[200],
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    size: 25,
                    color: indigo[500],
                  ),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.sp),
          height: 100.h - AppBar().preferredSize.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 35.sp),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password can't be empty!";
                        } else if (value.length < 8) {
                          return "Password must be at least 8 characters!";
                        }
                        return null;
                      },
                      obscureText: !passwordVisible,
                      textAlignVertical: TextAlignVertical.bottom,
                      controller: password,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 18),
                        suffixIcon: IconButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onPressed: () {
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                          },
                          icon: passwordVisible
                              ? Icon(
                                  Icons.remove_red_eye_outlined,
                                  color: indigo[400],
                                )
                              : Icon(
                                  Icons.visibility_off_outlined,
                                  color: slate[400],
                                ),
                        ),
                        hintText: "New password",
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
                    ),
                    SizedBox(height: 20.sp),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password can't be empty!";
                        } else if (value.length < 8) {
                          return "Password must be at least 8 characters!";
                        } else if (value != password.text) {
                          return "Password doesn't match!";
                        }
                        return null;
                      },
                      obscureText: !confirmPasswordVisible,
                      textAlignVertical: TextAlignVertical.bottom,
                      controller: confirmPassword,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 18),
                        suffixIcon: IconButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onPressed: () {
                            setState(() {
                              confirmPasswordVisible = !confirmPasswordVisible;
                            });
                          },
                          icon: confirmPasswordVisible
                              ? Icon(
                                  Icons.remove_red_eye_outlined,
                                  color: indigo[400],
                                )
                              : Icon(
                                  Icons.visibility_off_outlined,
                                  color: slate[400],
                                ),
                        ),
                        hintText: "Re-type new password",
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
                    ),
                    SizedBox(height: 20.sp),
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: 12.sp, horizontal: 20.sp),
                      child: AuthButtonWidget(
                        color: isSubmitting ? slate[300] : indigo[500],
                        child: isSubmitting
                            ? const AuthCircularIcons()
                            : const AuthTextButton(
                                innerText: 'Change password'),
                        onPressFunc: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              isSubmitting = true;
                            });
                            final res = await ChangePasswordController()
                                .changePassword(password.text,
                                    confirmPassword.text, userLoginEmail!);
                            await Future.delayed(
                                const Duration(milliseconds: 500));
                            if (res.statusCode == 200) {
                              toast(context, res.data['message'],
                                  ToastificationType.success);
                              await Future.delayed(
                                  const Duration(milliseconds: 1000));
                              if (widget.email != '') {
                                Navigator.of(context).pushNamed('/auth/signin');
                              } else {
                                Navigator.pop(context);
                              }
                            } else {
                              toast(context, res.data['message'] as String,
                                  ToastificationType.error);
                            }
                            setState(() {
                              isSubmitting = false;
                            });
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
