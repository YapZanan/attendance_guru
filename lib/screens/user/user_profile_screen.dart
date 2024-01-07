import 'package:attendance_guru/main.dart';
import 'package:attendance_guru/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/component_button.dart';
import '../../components/component_input_fields.dart';
import '../../constant.dart';
import '../../utils/navigation_utils.dart';
import '../../utils/update_data_utils.dart';
import '../../utils/upload_image.dart';

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
  late String imageUrl;

  ImageUploader imageUploader = ImageUploader();

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: screenHeight / 7,
                      bottom: screenHeight / 25,
                    ),
                    child: const Text(
                      "Update Profile",
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
                          hintText: "New Password",
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
                          textBaru: "Upload foto",
                          sideIcon: FontAwesomeIcons.camera,
                          onPressed: () async {
                            await imageUploader.uploadImage(
                                id: UserTest.userID,
                                context: context);
                            setState(() {
                              imageUrl = imageUploader.imageUrl;
                            });
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
                        const SizedBox(height: 200),
                        ComponentFilledButton(
                          textBaru: "Update Data",
                          onPressed: () {
                            UpdateUtils.updateUser(
                              context: context,
                              usernameController: usernameController,
                              emailController: emailController,
                              passwordController: passwordController,
                              userId: UserTest.userID,
                              collectionName: 'Karyawan',
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
          ),
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
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 24,
                  ),
                ),
                child: const Text(
                  "LogOut",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: FontSizes.md,
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
