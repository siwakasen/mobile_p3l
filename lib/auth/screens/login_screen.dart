import 'package:flutter/material.dart';
import 'package:mobile_p3l/auth/controllers/login_controller.dart';
import 'package:mobile_p3l/auth/widgets/auth_button_widget.dart';
import 'package:mobile_p3l/auth/widgets/auth_form_widget.dart';
import 'package:mobile_p3l/constants.dart';
import 'package:mobile_p3l/widgets/toast_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:toastification/toastification.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool passwordVisible = false;
  bool isSubmitting = false;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          width: 100.w,
          height: 100.h - AppBar().preferredSize.height,
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Welcome',
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w600,
                      fontSize: 24.sp,
                      color: indigo[600],
                    ),
                  ),
                  Text(
                    'back!',
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w600,
                      fontSize: 24.sp,
                      color: slate[900],
                      height: 1,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.sp),
                    child: Text(
                      'Silakan login untuk mengakses akun Anda. Nikmati kemudahan berbelanja di aplikasi kami.',
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.normal,
                        fontSize: 14.sp,
                        color: slate[400],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.sp),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 12.sp),
                        child: AuthFormWidget(
                          controller: email,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Email tidak boleh kosong!";
                            } else if (!value.contains('@')) {
                              return "Email tidak valid!";
                            }
                            return null;
                          },
                          hintText: 'Masukan alamat email',
                          icons: Icons.email_outlined,
                          type: TextInputType.emailAddress,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 12.sp),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Password tidak boleh kosong!";
                            }
                            return null;
                          },
                          obscureText: !passwordVisible,
                          textAlignVertical: TextAlignVertical.bottom,
                          controller: password,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 12),
                            prefixIcon: Icon(
                              Icons.vpn_key_outlined,
                              color: slate[400],
                            ),
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
                            hintText: "Masukan password",
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
                      ),
                      Container(
                          margin: EdgeInsets.only(
                              top: 12.sp, bottom: 12.sp, left: 10.sp),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed('/forget-password');
                            },
                            child: Text(
                              'Lupa password?',
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.normal,
                                fontSize: 14.sp,
                                color: indigo[500],
                              ),
                            ),
                          )),
                      Container(
                        margin: EdgeInsets.only(top: 20.sp),
                        child: AuthButtonWidget(
                          color: isSubmitting ? slate[300] : indigo[500],
                          child: isSubmitting
                              ? const AuthCircularIcons()
                              : const AuthTextButton(innerText: 'Log In'),
                          onPressFunc: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                isSubmitting = true;
                              });
                              final res = await LoginController().login(
                                email.text,
                                password.text,
                              );
                              // biar muncul dikit animasi cicleny
                              await Future.delayed(
                                  const Duration(milliseconds: 500));
                              if (res.statusCode == 200) {
                                Navigator.of(context)
                                    .pushNamed('/dashboard', arguments: 0);
                                toast(context, res.data['message'] as String,
                                    ToastificationType.success);
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
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
