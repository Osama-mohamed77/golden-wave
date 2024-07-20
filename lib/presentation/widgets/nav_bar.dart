import 'package:flutter/material.dart';
import 'package:golden_wave/constants/my_colors.dart';
import 'package:golden_wave/presentation/screens/history.dart';
import 'package:golden_wave/presentation/screens/home.dart';
import 'package:golden_wave/presentation/screens/profile.dart';
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
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listoption[_currenIndex],
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
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
            gap: 5,
            padding: const EdgeInsets.all(11),
            tabs: const [
              GButton(
                icon: Icons.home,
                iconColor: MyColors.myWhite,
                iconSize: 25,
                text: 'Home',
              ),
              GButton(
                icon: Icons.history,
                iconColor: MyColors.myWhite,
                iconSize: 25,
                text: 'History ',
              ),
              GButton(
                icon: Icons.person,
                iconColor: MyColors.myWhite,
                iconSize: 25,
                text: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
