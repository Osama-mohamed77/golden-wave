import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_wave/constants/my_colors.dart';
import 'package:golden_wave/provider/home_provider.dart';
import 'package:provider/provider.dart';

class SectionForm extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const SectionForm({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final provider = Provider.of<HomeProvider>(context, listen: false);
        provider.updateSelectedSection(0, title);
        provider.fetchServices();
        onTap();
      },
      child: Container(
        height: 43.h,
        padding:  EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: isSelected ? MyColors.myYellow : MyColors.myGrey,
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
              color: isSelected ? MyColors.myYellow : Colors.black,
              
            ),
          ),
        ),
      ),
    );
  }
}
