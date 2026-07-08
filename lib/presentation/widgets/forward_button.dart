import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_wave/provider/language_provider.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class ForwardButton extends StatelessWidget {
  final Function() onTap;
  const ForwardButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Consumer<LanguageProvider>(
        builder: (context, provider, child) {
          return provider.language == 'en'
              ? Container(
                  width: 50.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child:  Icon(Iconsax.arrow_right_2),
                )
              : Container(
                  width: 50.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child:  Icon(Iconsax.arrow_left_3),
                );
        },
      ),
    );
  }
}
