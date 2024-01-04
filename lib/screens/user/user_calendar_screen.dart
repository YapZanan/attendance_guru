// Import necessary libraries and files
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../components/component_check_in_out.dart';
import '../../constant.dart';
import '../../model/user_model.dart';

class UserCalendarScreen extends StatefulWidget {
  const UserCalendarScreen({Key? key}) : super(key: key);

  @override
  State<UserCalendarScreen> createState() => _UserCalendarScreenState();
}

class _UserCalendarScreenState extends State<UserCalendarScreen> {

  String monthYear = DateFormat('MMMM/yyyy').format(DateTime.now());

  // Initialize an empty list to store records
  List<Map<String, dynamic>> records = [];

  // Function to fetch records from Firebase
  Future<void> fetchRecords() async {
    // Replace "Karyawan" with your actual collection name
    CollectionReference recordCollection = FirebaseFirestore.instance
        .collection("Karyawan")
        .doc(UserTest.userID) // Replace with the actual user ID
        .collection("Record");

    try {
      // Get all documents from the "Record" collection
      QuerySnapshot querySnapshot = await recordCollection.get();

      // Iterate through the documents and add them to the records list
      records = querySnapshot.docs
          .map((DocumentSnapshot doc) {
        var data = doc.data() as Map<String, dynamic>;
        data["recordID"] = doc.id; // Add the document ID to the record data
        return data;
      }).toList();

      for (var record in records) {
        DateTime dateTime = DateFormat('dd MMMM yyyy', 'en_US').parse(record["recordID"]);
        String formattedDate = DateFormat('EE\ndd', 'en_US').format(dateTime);

        // Add the formatted date to the record
        record["formattedDate"] = formattedDate;
      }

      // Update the state to rebuild the widget with the new records
      setState(() {});
    } catch (e) {
      print("Error getting records: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    // Call fetchRecords when the widget is initialized
    fetchRecords();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(Margins.lg),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(
                top: Margins.xl,
              ),
              child: const Text(
                "Histori Presensi",
                style: TextStyle(
                  fontSize: FontSizes.xl,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                  color: AppColors.text,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // Use ListView.builder to dynamically create ComponentCheckInOut widgets
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: records.length,
              itemBuilder: (context, index) {
                return ComponentCheckInOut(
                  checkInTitle: "Check-In",
                  checkOutTitle: "Check-Out",
                  checkInTime: records[index]["checkIn"] ?? "--/--/--",
                  checkOutTime: records[index]["checkOut"] ?? "--/--/--",
                  textStyle: const TextStyle(
                    fontSize: FontSizes.md,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w400,
                    color: AppColors.text,
                  ),
                  yes: true,
                  timeStamp: records[index]["formattedDate"], // Use the formatted date here
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
