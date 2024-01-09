import 'package:attendance_guru/components/component_user_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../constant.dart';
import '../../model/user_model.dart';

class AdminLookDataState extends State<AdminLookDataScreen> {
  String monthYear = DateFormat('MMMM/yyyy').format(DateTime.now());
  List<Map<String, dynamic>> records = [];

  Future<void> refresh() async {
    // You can add any additional logic you need for refreshing here
    // For example, you can re-fetch records
    await fetchRecords();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchRecords();
  }

  static Future<String> getPhotoURL(String userId) async {
    try {
      Reference storageReference = FirebaseStorage.instance.ref().child('$userId/default_profile.jpg');
      String downloadURL = await storageReference.getDownloadURL();
      print("asdasdasdasd:");
      print(downloadURL);
      return downloadURL;
    } catch (e) {
      print("Error fetching photoURL: $e");
      return 'https://firebasestorage.googleapis.com/v0/b/presensiguru-41ee9.appspot.com/o/default_profile.jpg?alt=media&token=fe42f0b2-00f7-4aef-8dfa-0b0c36c16a1a';
    }
  }



  // Function to fetch records from Firebase
  Future<void> fetchRecords() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("Karyawan")
        .get();

    try {
      records = await Future.wait(querySnapshot.docs.map((DocumentSnapshot doc) async {
        var data = doc.data() as Map<String, dynamic>;
        data["userID"] = doc.id;
        data["photoURL"] = await getPhotoURL(data["userID"]);
        return data;
      }));

      print(records);
      setState(() {});
    } catch (e) {
      print("Error getting records: $e");
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: records.length,
              itemBuilder: (context, index){
                return ComponentUserList(
                    name: records[index]["userName"],
                    userID: records[index]["userID"],
                    email: "asdasdasd",
                    image: records[index]["photoURL"]);
              }
          )
        ],
      ),

    );
  }
}




class AdminLookDataScreen extends StatefulWidget {
  // const AdminLookData({super.key});

  const AdminLookDataScreen({Key? key}) : super(key: key);

  @override
  State<AdminLookDataScreen> createState() => AdminLookDataState();
}




