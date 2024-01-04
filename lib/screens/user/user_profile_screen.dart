import 'package:attendance_guru/main.dart';
import 'package:attendance_guru/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/component_button.dart';
import '../../components/component_input_fields.dart';
import '../../constant.dart';
import '../../utils/navigation_utils.dart';
import '../../utils/update_data_utils.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  late SharedPreferences sharedPreferences;

  double screenHeight = 0;
  double screenWidth = 0;
  bool eyeCondition = false;
  bool _isPasswordObscured = true;

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Center the Column
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: screenHeight / 25,
                    bottom: screenHeight / 25,
                  ),
                  child: const Text(
                    "Update Profile", // Change the title to indicate updating
                    style: TextStyle(
                      fontSize: FontSizes.xl,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                      color: AppColors.text,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      ComponentInputField(
                        icon: Icons.person,
                        hintText: "Username",
                        screenWidth: screenWidth,
                        obscureText: false,
                        showEyeButton: false,
                        onToggleVisibility: (isVisible) {},
                        controller: usernameController,
                      ),
                      ComponentInputField(
                        icon: Icons.mail_outline,
                        hintText: "Email",
                        screenWidth: screenWidth,
                        obscureText: false,
                        showEyeButton: false,
                        onToggleVisibility: (isVisible) {},
                        controller: emailController,
                      ),
                      ComponentInputField(
                        icon: Icons.lock,
                        hintText: "New Password", // Change the hint text for password
                        screenWidth: screenWidth,
                        obscureText: _isPasswordObscured,
                        showEyeButton: true,
                        onToggleVisibility: (isVisible) {
                          setState(() {
                            _isPasswordObscured = isVisible;
                          });
                        },
                        controller: passwordController,
                      ),
                      const SizedBox(height: Margins.lg),
                      ComponentFilledButton(
                        textBaru: "Update Data",
                        onPressed: () {
                          // Call the UpdateUtils.updateUser function here
                          UpdateUtils.updateUser(
                            context: context,
                            usernameController: usernameController,
                            emailController: emailController,
                            passwordController: passwordController,
                            userId: UserTest.userID, // Replace with the actual user document ID
                            collectionName: 'Karyawan', // Replace with your collection name
                          );
                        },
                        onLongPress: () {
                          Fluttertoast.showToast(
                            msg: "Update Profile button",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: AppColors.secondary,
                            textColor: AppColors.text,
                            fontSize: FontSizes.md,
                          );
                        },
                      ),
                      const SizedBox(height: Margins.lg),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Logout Button at the Top Right Corner
          Positioned(
            top: 32,
            right: 32,
            child: Container(
              child: ElevatedButton(
                onPressed: () async {
                  SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();
                  sharedPreferences.remove("userID");
                  sharedPreferences.remove("userRole");
                  sharedPreferences.remove("userName");
                  sharedPreferences.remove("email");

                  NavigationUtils.pushReplacement(context, const MyApp());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Set the button color to red
                  padding: const EdgeInsets.symmetric(
                    vertical: 16, // Increase the vertical padding
                    horizontal: 24, // Increase the horizontal padding
                  ),
                ),
                child: const Text(
                  "LogOut",
                  style: TextStyle(
                    color: Colors.white, // Set text color to white
                    fontSize: FontSizes.md, // Set text size
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
