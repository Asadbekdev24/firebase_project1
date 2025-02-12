import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_firebase_auth_project/home_screen.dart';
import 'package:flutter_application_firebase_auth_project/sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final SharedPreferences preferences = await SharedPreferences.getInstance();

  String? uid = preferences.getString("user");

  runApp(MyApp(userId: uid));
}

class MyApp extends StatelessWidget {
  final String? userId;

  const MyApp({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:userId != null ? HomeScreen(userId: userId,) :  SignInScreen(),
    );
  }
}

//userId != null ? HomeScreen() :