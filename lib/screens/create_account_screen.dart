import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/component_rich_text.dart';
import '../constant.dart';
import '../components/component_login_header.dart';
import '../components/component_input_fields.dart';
import '../components/component_button.dart';
import '../utils/registration_utils.dart'; // Import the new registration utils
import '../utils/navigation_utils.dart';
import 'login_screen.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  late SharedPreferences sharedPreferences;

  double screenHeight = 0;
  double screenWidth = 0;
  bool eyeCondition = false;
  bool _isPasswordObscured = true;

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void togglePassword() {
    setState(() {
      eyeCondition = !eyeCondition;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isKeyboardVisible =
    KeyboardVisibilityProvider.isKeyboardVisible(context);
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 24.0),
          isKeyboardVisible
              ? const SizedBox()
              : ComponentLoginHeader(
            screenHeight: screenHeight,
            screenWidth: screenWidth,
          ),
          Container(
            margin: EdgeInsets.only(
              top: screenHeight / 25,
              bottom: screenHeight / 25,
            ),
            child: const Text(
              "SignUp",
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
                  icon: Icons.email_outlined,
                  hintText: "Email",
                  screenWidth: screenWidth,
                  obscureText: false,
                  showEyeButton: false,
                  onToggleVisibility: (isVisible) {},
                  controller: emailController,
                ),
                ComponentInputField(
                  icon: Icons.lock,
                  hintText: "Password",
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
                  onPressed: () {
                    // Call the RegistrationUtils.registerUser function here
                    RegistrationUtils.registerUser(
                      context: context,
                      usernameController: usernameController,
                      emailController: emailController,
                      passwordController: passwordController,
                      collectionName: 'Karyawan', // Replace with your collection name
                      successScreen: const KeyboardVisibilityProvider(child: LoginScreen(),), // Replace with your login screen widget
                      failureScreen: const KeyboardVisibilityProvider(child: CreateAccountScreen(),), // Replace with your create account screen widget
                    );
                  },
                  onLongPress: () {
                    Fluttertoast.showToast(
                      msg: "Create Account button",
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
          const Spacer(),
        ],
      ),
    );
  }
}
