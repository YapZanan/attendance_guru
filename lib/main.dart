import 'package:attendance_guru/model/user_model.dart';
import 'package:attendance_guru/screens/admin/admin_dashboard.dart';
import 'package:attendance_guru/screens/user/user_dashboard_screen.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug,
  );


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Presensi Guru',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const KeyboardVisibilityProvider(child: AuthCheck()),
      localizationsDelegates: const [
        MonthYearPickerLocalizations.delegate
      ],
    );
  }
}

class AuthCheck extends StatefulWidget {
  const AuthCheck({Key? key}) : super(key: key);

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  String userRole = "";
  late SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  void _getCurrentUser() async {
    sharedPreferences = await SharedPreferences.getInstance();

    // var userIDTemp = sharedPreferences.getString("userID");
    // var userRoleTemp = sharedPreferences.getString("userRole");
    // var userName = sharedPreferences.getString("userName");
    // var userEmail = sharedPreferences.getString("email");
    var email = sharedPreferences.getString('email');
    var userName = sharedPreferences.getString('userName');
    var role = sharedPreferences.getString('userRole');
    var userID = sharedPreferences.getString('userID');
    var photoURL = sharedPreferences.getString('photoURL');

    print("email: $email");
    print("username: $userName");
    print("role: $role");
    print("userID: $userID");
    print("photoURL: $photoURL");



    try {
      if (email != null && email.isNotEmpty && role != null && role.isNotEmpty) {
        UserTest.userName = userName.toString();
        UserTest.userID = userID.toString();
        UserTest.photoURL = photoURL.toString();
        print(UserTest.userID);
        print(UserTest.userName);
        setState(() {
          userRole = role;
        });
      }
    } catch (e) {
      setState(() {
        userRole = "";
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return userRole == "admin"
        ? const AdminDashboardScreen()
        : userRole == "karyawan"
        ? const UserDashboardScreen()
        : const LoginScreen();
  }
}
