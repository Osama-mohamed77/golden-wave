import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:golden_wave/constants/my_colors.dart';
import 'package:golden_wave/generated/l10n.dart';
import 'package:golden_wave/provider/history_provider.dart';
import 'package:provider/provider.dart';

class History extends StatefulWidget {
  static String id = 'History';
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    // Initialize the AnimationController
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this, // Corrected this line
    );

    Future.microtask(() => Provider.of<HistoryProvider>(context, listen: false)
        .fetchBookingDate());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF0F0F0),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xffC9C9C9),
                MyColors.myYellow,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Center(
          child: Text(
            S.of(context).bookingHistory,
            style: TextStyle(
              fontFamily: 'alata',
              fontSize: 23.sp,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 20.0.h, left: 20.w, right: 20.w),
        child: Consumer<HistoryProvider>(
          builder: (context, historyProvider, child) {
            // Start the animation when the widget builds
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _controller.forward();
            });

            return ListView.builder(
              itemCount: historyProvider.bookings.length,
              itemBuilder: (context, index) {
                final booking = historyProvider.bookings[index];

                // Create an animation for each item
                final itemAnimation = Tween<Offset>(
                  begin: Offset(1.0.r, 0.0),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: _controller,
                  curve: Interval(
                    (1 / historyProvider.bookings.length) * index,
                    1.0,
                    curve: Curves.easeInOut,
                  ),
                ));

                return AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return SlideTransition(
                      position: itemAnimation,
                      child: child,
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 15.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(
                        colors: [Colors.brown, MyColors.myGrey],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2.r,
                          blurRadius: 5.r,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0.w, vertical: 15.0.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.date_range_sharp,
                                color: MyColors.myWhite,
                                size: 25.r,
                              ),
                              Gap(10.w),
                              Text(
                                '${S.of(context).bookingDate}: ${booking.bookingDate}',
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                  color: MyColors.myWhite,
                                ),
                              ),
                            ],
                          ),
                          Gap(10.h),
                          Row(
                            children: [
                              Icon(Icons.music_note,
                                  color: MyColors.myWhite, size: 25.r),
                              Gap(10.w),
                              Text(
                                '${S.of(context).serviceName}: ${booking.serviceName}',
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                  color: MyColors.myWhite,
                                ),
                              ),
                            ],
                          ),
                          Gap(10.h),
                          Row(
                            children: [
                              Icon(Icons.phone,
                                  color: MyColors.myWhite, size: 25.r),
                              Gap(10.w),
                              Text(
                                '${S.of(context).phoneNumber}: ${booking.phoneNumber}',
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                  color: MyColors.myWhite,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
