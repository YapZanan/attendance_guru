import 'package:attendance_guru/screens/admin/admin_look_data_screen.dart';
import 'package:attendance_guru/screens/admin/admin_profile_screen.dart';
import 'package:attendance_guru/screens/admin/admin_set_jam_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../components/component_navbar.dart';
import '../../constant.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  double screenHeight = 0;
  double screenWidth = 0;

  List<IconData> navigationIcons = [
    FontAwesomeIcons.solidClock,
    FontAwesomeIcons.book,
    FontAwesomeIcons.userLarge,
  ];

  int currentIndex = 1;

  GlobalKey<AdminLookDataState> lookDataKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: IndexedStack(
        index: currentIndex,
        children: [
          new AdminSetJamScreen(),
          new AdminLookDataScreen(key: lookDataKey),
          new AdminProfileScreen(),

        ],
      ),
      bottomNavigationBar: ComponentNavbar(
        screenHeight: screenHeight,
        screenWidth: screenWidth,
        currentIndex: currentIndex,
        navigationIcons: navigationIcons,
        onTabTapped: (index) {
          if (index == 1) {
            lookDataKey.currentState?.refresh();
          }
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
