import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_wave/constants/my_colors.dart';
import 'package:golden_wave/generated/l10n.dart';
import 'package:golden_wave/presentation/screens/history.dart';
import 'package:golden_wave/presentation/screens/home.dart';
import 'package:golden_wave/presentation/screens/settings.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});
  static String id = 'HomeNavBarPatient';
  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _currenIndex = 0;
  final List<Widget> listoption = <Widget>[
    const Home(),
    const History(),
    const Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listoption[_currenIndex],
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 30.w, vertical: 8.h),
          child: GNav(
            selectedIndex: _currenIndex,
            onTabChange: (value) {
              setState(() {
                _currenIndex = value;
              });
            },
            haptic: true,
            backgroundColor: Colors.black,
            color: Colors.white,
            activeColor: MyColors.myYellow,
            tabBackgroundColor: const Color(0xff424242),
            gap: 5.r,
            padding:  EdgeInsets.all(11.r),
            tabs:  [
              GButton(
                icon: Icons.home,
                iconColor: MyColors.myWhite,
                iconSize: 25.r,
                text: S.of(context).home,textStyle: TextStyle(fontFamily: 'inter',fontSize: 14.sp,color: MyColors.myYellow),
              ),
              GButton(
                icon: Icons.history,
                iconColor: MyColors.myWhite,
                iconSize: 25.r,
                text: S.of(context).bookingHistory,textStyle: TextStyle(fontFamily: 'inter',fontSize: 14.sp,color: MyColors.myYellow),
              ),
              GButton(
                icon: Icons.person,
                iconColor: MyColors.myWhite,
                iconSize: 25.r,
                text: S.of(context).settings,textStyle: TextStyle(fontFamily: 'inter',fontSize: 14.sp,color: MyColors.myYellow),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
