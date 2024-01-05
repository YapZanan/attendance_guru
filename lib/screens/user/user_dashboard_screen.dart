import 'package:attendance_guru/constant.dart';
import 'package:attendance_guru/screens/user/user_calendar_screen.dart';
import 'package:attendance_guru/screens/user/user_profile_screen.dart';
import 'package:attendance_guru/screens/user/user_today_screen.dart';
import 'package:attendance_guru/components/component_navbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserDashboardScreen extends StatefulWidget {
  const UserDashboardScreen({Key? key}) : super(key: key);

  @override
  State<UserDashboardScreen> createState() => _UserDashboardScreenState();
}


class _UserDashboardScreenState extends State<UserDashboardScreen> {
  double screenHeight = 0;
  double screenWidth = 0;

  List<IconData> navigationIcons = [
    FontAwesomeIcons.calendarDay,
    FontAwesomeIcons.check,
    FontAwesomeIcons.userLarge,
  ];

  int currentIndex = 1;

  // GlobalKey to access the UserCalendarScreen state
  GlobalKey<UserCalendarScreenState> calendarKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: IndexedStack(
        index: currentIndex,
        children: [
          UserCalendarScreen(key: calendarKey),
          UserTodayScreen(),
          UserProfileScreen(),
        ],
      ),
      bottomNavigationBar: ComponentNavbar(
        screenHeight: screenHeight,
        screenWidth: screenWidth,
        currentIndex: currentIndex,
        navigationIcons: navigationIcons,
        onTabTapped: (index) {
          // Refresh UserCalendarScreen when the corresponding tab is tapped
          if (index == 0) {
            calendarKey.currentState?.refresh();
          }

          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
