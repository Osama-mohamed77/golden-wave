import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_wave/constants/my_colors.dart';
import 'package:golden_wave/presentation/screens/booking_screen.dart';
import 'package:golden_wave/provider/booking_provider.dart';
import 'package:provider/provider.dart';

class ServiceCard extends StatelessWidget {
  final String title;

  const ServiceCard(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<BookingProvider>(context, listen: false).getTitle(title);

        Navigator.pushNamed(context, BookingScreen.id);
      },
      child: Padding(
        padding:  EdgeInsets.all(5.0.r),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: MyColors.myYellow),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Center(
            child: Text(
              title,
              style:  TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'inter',
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
