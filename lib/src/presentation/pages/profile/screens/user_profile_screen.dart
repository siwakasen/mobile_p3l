// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_p3l/src/utils/constants.dart';
import 'package:mobile_p3l/src/presentation/pages/profile/controllers/change_password_controller.dart';
import 'package:mobile_p3l/src/presentation/widgets/toast/toast_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:toastification/toastification.dart';
import 'package:intl/intl.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  String? name = '';
  String? email = '';
  String? poin = '0';
  String? saldo = '0';
  String? formattedSaldo;

  @override
  void initState() {
    getDataUser();
    super.initState();
  }

  void getDataUser() async {
    String? getEmail = await loadPreference('email');
    String? getPoin = await loadPreference('poin');
    String? getSaldo = await loadPreference('saldo');
    String? getName = await loadPreference('nama');
    setState(() {
      name = getName ?? '';
      email = getEmail ?? '';
      poin = getPoin ?? '0';
      saldo = getSaldo ?? '0';
      formattedSaldo = saldo != null
          ? NumberFormat("#,##0", "en_US").format(int.parse(saldo!))
          : '0';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 5.h),
            SizedBox(
              width: 100.w,
              height: 28.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 30.w,
                    height: 30.w,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/images/profile-user.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    '$name',
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w600,
                      fontSize: 22.sp,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Icon(
                            // FontAwesomeIcons.star,
                            Icons.star,
                            color: Colors.black,
                            size: 19.sp,
                          ),
                          SizedBox(width: 1.w),
                          Text(
                            '$poin Point',
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w600,
                              fontSize: 15.sp,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 4.w),
                      Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.wallet,
                            color: Colors.black,
                            size: 16.sp,
                          ),
                          SizedBox(width: 1.w),
                          Text(
                            'Rp $formattedSaldo',
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w600,
                              fontSize: 15.sp,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 2.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.sp),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 30.sp,
                            height: 30.sp,
                            decoration: BoxDecoration(
                              color: Colors.indigo[200],
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(16.sp),
                            ),
                            padding: EdgeInsets.all(6.sp),
                            child: Icon(
                              Icons.person,
                              color: Colors.indigo[500],
                              size: 22.sp,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            'Personal Information',
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w600,
                              fontSize: 17.sp,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                          size: 18.sp,
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed("/personal-information", arguments: '');
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 3.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 30.sp,
                            height: 30.sp,
                            decoration: BoxDecoration(
                              color: Colors.indigo[200],
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(16.sp),
                            ),
                            padding: EdgeInsets.all(6.sp),
                            child: Icon(
                              FontAwesomeIcons.key,
                              color: Colors.indigo[500],
                              size: 20.sp,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            'Change Password',
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w600,
                              fontSize: 17.sp,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                          size: 18.sp,
                        ),
                        onPressed: () async {
                          toast(
                              context,
                              "Please wait, we sending email verification to your email address",
                              ToastificationType.success);
                          final res = await ChangePasswordController()
                              .sendRequest(email!);
                          if (res.statusCode == 200) {
                            Navigator.of(context)
                                .pushNamed("/change-password", arguments: '');
                            toast(context, res.data['message'],
                                ToastificationType.success);
                          } else {
                            toast(context, res.data['message'] as String,
                                ToastificationType.error);
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 3.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 30.sp,
                            height: 30.sp,
                            decoration: BoxDecoration(
                              color: Colors.indigo[200],
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(16.sp),
                            ),
                            padding: EdgeInsets.all(6.sp),
                            child: Icon(
                              FontAwesomeIcons.mapMarkerAlt,
                              color: Colors.indigo[500],
                              size: 20.sp,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            'Add or Change Address',
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w600,
                              fontSize: 17.sp,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                          size: 18.sp,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: 3.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 30.sp,
                            height: 30.sp,
                            decoration: BoxDecoration(
                              color: Colors.indigo[200],
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(16.sp),
                            ),
                            padding: EdgeInsets.all(6.sp),
                            child: Icon(
                              FontAwesomeIcons.shoppingCart,
                              color: Colors.indigo[500],
                              size: 20.sp,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            'Order on Progress',
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w600,
                              fontSize: 17.sp,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                          size: 18.sp,
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed("/order-on-progress", arguments: '');
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 3.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 30.sp,
                            height: 30.sp,
                            decoration: BoxDecoration(
                              color: Colors.indigo[200],
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(16.sp),
                            ),
                            padding: EdgeInsets.all(6.sp),
                            child: Icon(
                              FontAwesomeIcons.history,
                              color: Colors.indigo[500],
                              size: 20.sp,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            'Order History',
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w600,
                              fontSize: 17.sp,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                          size: 18.sp,
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed("/order-history", arguments: '');
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
