import 'package:attendance_guru/model/user_model.dart';
import 'package:attendance_guru/screens/create_account_screen.dart';
import 'package:attendance_guru/screens/user/user_dashboard_screen.dart';
import 'package:attendance_guru/utils/get_name.dart';
import 'package:attendance_guru/utils/get_string_lowtrim.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/component_rich_text.dart';
import '../constant.dart';
import '../components/component_login_header.dart';
import '../components/component_input_fields.dart';
import '../components/component_button.dart';
import '../utils/auth_utils.dart';
import '../utils/navigation_utils.dart';
import '../utils/get_data_utils.dart';
import 'admin/admin_dashboard.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late SharedPreferences sharedPreferences;

  double screenHeight = 0;
  double screenWidth = 0;
  bool eyeCondition = false;
  bool _isPasswordObscured = true;

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
              DefaultText.signIn,
              style: TextStyle(
                fontSize: FontSizes.xl,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
                color: AppColors.text,
              ),
            ),
          ),

          // Wrap the input fields and button with a container
          Container(
            margin: const EdgeInsets.all(30),
            child: Column(
              children: [
                ComponentInputField(
                  icon: Icons.person,
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
                Container(
                  alignment: Alignment.centerRight,
                  child: ComponentRichText(
                    text: 'Lupa Password?',
                    clickableText: '',
                    onPressed: () {
                      NavigationUtils.pushScreen(
                          context, const ForgotPasswordScreen());
                    },
                    textStyle: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                        fontSize: FontSizes.sm),
                    clickableTextStyle: const TextStyle(
                      color: Colors.blue,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const SizedBox(height: Margins.xl),
                ComponentFilledButton(
                  onPressed: () {
                    // Call the AuthUtils.loginUser function here
                    AuthUtils.loginUser(
                      context: context,
                      emailController: emailController,
                      passwordController: passwordController,
                      collectionName: 'Karyawan', // Replace with your collection name
                      adminScreen: const AdminDashboardScreen(), // Replace with your admin screen widget
                      userScreen: const UserDashboardScreen(), // Replace with your user screen widget
                    );
                  },
                  onLongPress: () {
                    Fluttertoast.showToast(
                      msg: "Sign-In button",
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
          Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.only(bottom: Margins.xl),
            child: ComponentRichText(
              text: 'Belum Punya Akun? ',
              clickableText: 'Klik Di sini',
              onPressed: () {
                NavigationUtils.pushScreen(
                    context, const CreateAccountScreen());
              },
              textStyle: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                  fontSize: FontSizes.md),
              clickableTextStyle: const TextStyle(
                color: Colors.blue,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w400,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
