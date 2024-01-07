import 'package:attendance_guru/constant.dart';
import 'package:attendance_guru/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:attendance_guru/utils/get_day.dart';
import 'package:attendance_guru/utils/get_hours.dart';
import 'package:intl/intl.dart';
import 'package:slide_to_act/slide_to_act.dart';

import '../../components/component_slide_action.dart';
import 'package:attendance_guru/components/component_user_info.dart';
import 'package:attendance_guru/components/component_status_info.dart';
import 'package:attendance_guru/components/component_time_display.dart';
import 'package:attendance_guru/components/component_check_in_out.dart';

class UserTodayScreen extends StatefulWidget {
  // Define a key to access the state of this widget
  const UserTodayScreen({Key? key}) : super(key: key);

  @override
  State<UserTodayScreen> createState() => UserTodayScreenState();
}

class UserTodayScreenState extends State<UserTodayScreen> {
  bool isCheckIn = true;
  bool isDisabled = false;
  bool isTime = true;
  final GlobalKey<SlideActionState> _slideActionKey = GlobalKey();
  final GetTime getTime = GetTime();
  final GetDay getYear = GetDay();
  String jamMasuk = "--/--/--";
  String jamKeluar = "--/--/--";

  String jamMasukUser = "--/--/--";
  String jamKeluarUser = "--/--/--";

  @override
  void initState() {
    super.initState();
    getTime.startUpdatingTime();
    getYear.startUpdatingTime();
    _getTime();
    _getUserTime("checkIn").then((value) {
      setState(() {
        jamMasukUser = value ?? "--/--/--";
        print(jamMasukUser);
        isCheckIn = jamMasukUser == "--/--/--" && jamKeluarUser == "--/--/--" ? true : false;
        print(isCheckIn);
      });
    });
    _getUserTime("checkOut").then((value) {
      setState(() {
        jamKeluarUser = value ?? "--/--/--";
        isDisabled = jamKeluarUser == "--/--/--" ? false : true;
      });
    });
  }

  Future<String?> _getUserTime(String kondisi) async {
    try {
      DocumentSnapshot snap2 = await FirebaseFirestore.instance
          .collection("Karyawan")
          .doc(UserTest.userID)
          .collection("Record")
          .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
          .get();

      CollectionReference recordCollection = FirebaseFirestore.instance
          .collection("Karyawan")
          .doc(UserTest.userID)
          .collection("Record");

      return snap2[kondisi];
    } catch (e) {
      return null;
    }
  }

  void _getTime() async {
    DocumentSnapshot snap2 = await FirebaseFirestore.instance
        .collection("Admin")
        .doc("jamKerja")
        .get();
    try {
      setState(() {
        jamMasuk = snap2['jamMasuk'];
        jamKeluar = snap2['jamKeluar'];
      });
    } catch (e) {
      setState(() {
        jamMasuk = "--/--/--";
        jamKeluar = "--/--/--";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(Margins.lg),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(
                        top: Margins.xl,
                      ),
                      child: const Text(
                        "Selamat Datang,",
                        style: TextStyle(
                          fontSize: FontSizes.lg,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w300,
                          color: AppColors.text,
                        ),
                      ),
                    ),
                    const ComponentUserInfo(),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: Margins.xl,
                  ),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(UserTest.photoURL),
                  ),
                ),
              ],
            ),
            const ComponentStatusInfo(textTitle: "Jadwal Hari Ini:"),
            ComponentCheckInOut(
                checkInTitle: "Check-In",
                checkOutTitle: "Check-Out",
                checkInTime: jamMasuk,
                checkOutTime: jamKeluar),
            const ComponentStatusInfo(textTitle: "Presensi Anda:"),
            ComponentCheckInOut(
                checkInTitle: "Check-In",
                checkOutTitle: "Check-Out",
                checkInTime: jamMasukUser,
                checkOutTime: jamKeluarUser),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(
                top: Margins.lg,
              ),
              child: ComponentTimeDisplay(timeStream: getYear.timeStream),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(
                top: Margins.sm,
              ),
              child: ComponentTimeDisplay(timeStream: getTime.timeStream),
            ),
            Container(
              padding: const EdgeInsets.only(top: Margins.lg),
              child: ComponentSlideAction(
                slideActionKey: _slideActionKey,
                textIn: "Geser Untuk Check-in",
                textOut: "Geser Untuk Check-Out",
                isCheckIn: isCheckIn,
                isDisabled: !isDisabled,
                onSlide: () async {
                  String jamNow = DateFormat('HH:mm:ss').format(DateTime.now());
                  if (isCheckIn && jamNow.compareTo(jamMasuk) < 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Belum waktunya CheckIn', textAlign: TextAlign.center),
                      ),
                    );
                    return;
                  }
                  if (!isCheckIn && jamNow.compareTo(jamKeluar) < 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Belum waktunya CheckOut', textAlign: TextAlign.center),
                      ),
                    );
                    return;
                  }
                  DocumentReference userRecordRef = FirebaseFirestore.instance
                      .collection("Karyawan")
                      .doc(UserTest.userID)
                      .collection("Record")
                      .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()));

                  DocumentSnapshot userRecordSnapshot = await userRecordRef.get();
                  try {
                    String checkIn = userRecordSnapshot['checkIn'];
                    await userRecordRef.update({
                      'checkOut': DateFormat('HH:mm:ss').format(DateTime.now()),
                    });
                    setState(() {
                      jamKeluarUser = DateFormat('HH:mm:ss').format(DateTime.now());
                      isDisabled = true;
                    });
                  } catch (e) {
                    await userRecordRef.set({
                      'checkIn': DateFormat('HH:mm:ss').format(DateTime.now()),
                    });
                    setState(() {
                      jamMasukUser = DateFormat('HH:mm:ss').format(DateTime.now());
                    });
                  }
                  setState(() {
                    isCheckIn = !isCheckIn;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    getTime.dispose();
    super.dispose();
  }
}
