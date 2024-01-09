import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:attendance_guru/constant.dart';
import 'package:attendance_guru/screens/admin/admin_calendar_screen.dart';
import 'package:attendance_guru/utils/navigation_utils.dart';

class ComponentUserList extends StatefulWidget {
  final String name;
  final String userID;
  final String email;
  final String image;
  final String role;

  const ComponentUserList({
    super.key,
    required this.name,
    required this.userID,
    required this.email,
    required this.image,
    required this.role,
  });

  @override
  _ComponentUserListState createState() => _ComponentUserListState();
}

class _ComponentUserListState extends State<ComponentUserList> {
  late String selectedRole;

  get sharedPreferences => null;

  @override
  void initState() {
    super.initState();
    selectedRole = widget.role; // Set the initial value to the default role
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            NavigationUtils.pushScreen(
              context,
              AdminCalendarScreen(userID: widget.userID, name: widget.name),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(
              top: Margins.md,
            ),
            height: 100,
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(2, 2),
                )
              ],
              borderRadius: BorderRadius.all(Radius.circular(RadiusConstant.xl)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(),
                  padding: const EdgeInsets.only(
                    left: 30,
                  ),
                  child: Center(
                    child: Container(
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(widget.image),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.name,
                        style: const TextStyle(
                          fontSize: FontSizes.lg,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w400,
                          color: AppColors.text,
                        ),
                      ),
                      Text(
                        widget.email,
                        style: const TextStyle(
                          fontSize: FontSizes.lg,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w400,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
                // Dropdown Button
                DropdownButton<String>(
                  value: selectedRole,
                  onChanged: (String? newValue) async {

                    await FirebaseFirestore.instance
                        .collection("Karyawan")
                        .doc(widget.userID)
                        .update({'role': newValue!});
                    setState(() {
                      selectedRole = newValue!;
                      print('Selected Role: $selectedRole');
                    });
                  },
                  items: <String>['admin', 'karyawan']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
