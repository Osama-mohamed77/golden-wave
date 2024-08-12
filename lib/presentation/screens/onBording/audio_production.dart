import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:golden_wave/constants/my_colors.dart';
import 'package:golden_wave/generated/l10n.dart';

class AudioProduction extends StatelessWidget {
  const AudioProduction({super.key});

  Widget title(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          S.of(context).AudioTitel,
          style: TextStyle(
            fontSize: 25.0.sp,
            fontFamily: 'inter',
            color: MyColors.myYellow,
          ),
        ),
      ],
    );
  }

  Widget details(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
      child: Center(
        child: Text(
          S.of(context).AudioHint,
          style: TextStyle(
            fontSize: 17.0.sp, // Static font size
            fontFamily: 'inter',
            color: MyColors.myWhite,
          ),
        ),
      ),
    );
  }

  Widget backgroundImage() {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Image.asset(
        'assets/images/Audio.png',
        fit: BoxFit.cover,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Stack(
        children: [
          backgroundImage(),
          Column(
            children: [
             Gap(150.h),
              title(context),
              Gap(20.h),
              details(context),
              
            ],
          ),
        ],
      ),
    );
  }
}
