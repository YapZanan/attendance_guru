import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../constant.dart';

class AdminSetJamScreen extends StatefulWidget {
  const AdminSetJamScreen({Key? key}) : super(key: key);

  @override
  State<AdminSetJamScreen> createState() => _AdminSetJamScreenState();
}

class _AdminSetJamScreenState extends State<AdminSetJamScreen> {
  List<Map<String, dynamic>> records = [];
  TimeOfDay? checkInTime;
  TimeOfDay? checkOutTime;

  Future<void> _selectCheckInTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: checkInTime ?? TimeOfDay.now(),
    );

    if (picked != null && picked != checkInTime) {
      setState(() {
        checkInTime = TimeOfDay(hour: picked.hour, minute: picked.minute);
      });

      // Convert TimeOfDay to DateTime
      DateTime now = DateTime.now();
      DateTime checkInDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        checkInTime!.hour,
        checkInTime!.minute,
      );

      // Format DateTime to 'HH:mm:ss' string
      String formattedTime = DateFormat('HH:mm:ss').format(checkInDateTime);

      await FirebaseFirestore.instance
          .collection("Admin")
          .doc("jamKerja")
          .update({'jamMasuk': formattedTime});
    }
  }


  Future<void> _selectCheckOutTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: checkOutTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != checkOutTime) {
      setState(() {
        checkOutTime = TimeOfDay(hour: picked.hour, minute: picked.minute);
      });
      // Convert TimeOfDay to DateTime
      DateTime now = DateTime.now();
      DateTime checkInDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        checkOutTime!.hour,
        checkOutTime!.minute,
      );

      // Format DateTime to 'HH:mm:ss' string
      String formattedTime = DateFormat('HH:mm:ss').format(checkInDateTime);

      await FirebaseFirestore.instance
          .collection("Admin")
          .doc("jamKerja")
          .update({'jamKeluar': formattedTime});
    }
  }

  Future<void> fetchRecords() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("Admin")
        .get();

    try {
      records = await Future.wait(querySnapshot.docs.map((DocumentSnapshot doc) async {
        var data = doc.data() as Map<String, dynamic>;
        return data;
      }));
      print("test records: ");
      print(records);
      if (records.isNotEmpty) {
        var jamMasuk = records[0]['jamMasuk'].toString();
        var jamKeluar = records[0]['jamKeluar'].toString();

        setState(() {
          checkInTime = TimeOfDay(
            hour: int.parse(jamMasuk.split(':')[0]),
            minute: int.parse(jamMasuk.split(':')[1]),
          );
          checkOutTime = TimeOfDay(
            hour: int.parse(jamKeluar.split(':')[0]),
            minute: int.parse(jamKeluar.split(':')[1]),
          );
        });
      }
    } catch (e) {
      print("Error getting records: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchRecords();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _selectCheckInTime(context),
              child: Text(
                checkInTime == null
                    ? 'Select Check-In Time'
                    : 'Check-In Time: ${_formatTime(checkInTime!)}',
                style: const TextStyle(
                  fontSize: FontSizes.lg,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                  color: AppColors.text,
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _selectCheckOutTime(context),
              child: Text(
                checkOutTime == null
                    ? 'Select Check-Out Time'
                    : 'Check-Out Time: ${_formatTime(checkOutTime!)}',
                style: const TextStyle(
                  fontSize: FontSizes.lg,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                  color: AppColors.text,
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  String _formatTime(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:00';
  }
}
