import 'package:flutter/material.dart';
import 'package:mobile_p3l/auth/widgets/auth_button_widget.dart';
import 'package:mobile_p3l/constants.dart';
import 'package:mobile_p3l/profile/controllers/change_password_controller.dart';
import 'package:mobile_p3l/widgets/toast_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:toastification/toastification.dart';
import 'package:email_validator/email_validator.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  TextEditingController emailController = TextEditingController();
  bool isSubmitting = false;
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        centerTitle: true,
        elevation: 0,
        leadingWidth: 22.5.w,
        leading: Container(
          child: Row(
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
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 10.sp),
              Text(
                "Email Verification",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  color: Colors.indigo[400],
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 12.sp),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email can't be empty!";
                          } else if (!EmailValidator.validate(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                        textAlignVertical: TextAlignVertical.bottom,
                        controller: emailController,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 18),
                          hintText: "Email",
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
                    Text(
                      "You may receive email verification from us for security and login purposes.",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        color: slate[500],
                      ),
                    ),
                    SizedBox(height: 20.sp),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 12.sp),
                      child: AuthButtonWidget(
                        color: isSubmitting ? slate[300] : indigo[500],
                        child: isSubmitting
                            ? const AuthCircularIcons()
                            : const AuthTextButton(innerText: 'Continue'),
                        onPressFunc: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              isSubmitting = true;
                            });
                            toast(
                                context,
                                "Please wait, we sending email verification to your email address",
                                ToastificationType.success);
                            final res = await ChangePasswordController()
                                .sendRequest(emailController.text);
                            print(res.data['message']);
                            if (res.statusCode == 200) {
                              Navigator.of(context).pushNamed(
                                  "/change-password",
                                  arguments: emailController.text);
                              toast(context, res.data['message'],
                                  ToastificationType.success);
                            } else {
                              toast(context, res.data['message'] as String,
                                  ToastificationType.error);
                            }
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
