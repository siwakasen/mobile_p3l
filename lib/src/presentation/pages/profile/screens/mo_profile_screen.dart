import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:mobile_p3l/src/utils/constants.dart';

class MOProfileScreen extends StatefulWidget {
  const MOProfileScreen({super.key});

  @override
  State<MOProfileScreen> createState() => _MOProfileScreenState();
}

class _MOProfileScreenState extends State<MOProfileScreen> {
  String? name = '';
  String? email = '';
  String? role = '';

  @override
  void initState(){
    getDataUser();
    super.initState();
  }

  void getDataUser() async {
    String? getName = await loadPreference('nama');
    String? getEmail = await loadPreference('email');
    String? getRole = await loadPreference('role');
    setState(() {
      name = getName;
      email = getEmail;
      role = getRole;
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
                  Text(
                    '$role',
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w600,
                      fontSize: 15.sp,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5.h),
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
                              Icons.file_copy,
                              color: Colors.indigo[500],
                              size: 22.sp,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            'Laporan Penggunaan\nBahan Baku',
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
                              .pushNamed("/laporan/laporan-penggunaan-bahan-baku", arguments: '');
                        },
                      ),
                    ],
                  ),
                ]
              )
            )
          ]
        )
      )
    );
  }
}