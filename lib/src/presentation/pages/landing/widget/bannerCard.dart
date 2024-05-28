import 'package:flutter/material.dart';
import 'package:mobile_p3l/src/utils/constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BannerCard extends StatelessWidget {
  final String index;
  const BannerCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset(
            'assets/images/${index}',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        Container(
          width: 100.w,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                slate[50]!.withOpacity(0.3),
                slate[200]!.withOpacity(0.001),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
