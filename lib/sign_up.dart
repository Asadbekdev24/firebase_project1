import 'package:flutter/material.dart';
import 'package:flutter_application_firebase_auth_project/auth_service.dart';
import 'package:flutter_application_firebase_auth_project/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final AuthService authService = AuthService();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    email.dispose();
    password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              SizedBox(
                height: 32,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: email,
                decoration: InputDecoration(
                  hintText: "Enter your email",
                  border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                ),
              ),
              SizedBox(
                height: 32,
              ),
              TextFormField(
                controller: password,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Enter your password",
                  border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                ),
              ),
              SizedBox(
                height: 32,
              ),
              ElevatedButton(
                  onPressed: () async {
                    final javob = await authService.signUp(
                        email.text.trim(), password.text.trim());
                    final SharedPreferences preferences= await SharedPreferences.getInstance();
                    if (javob != null) {
                      print("yaxshi");
                      preferences.setString("user", javob.uid);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(userId: javob.uid,),
                          ));
                    }else
                    {
                      print("yomon");
                    }
                  },
                  child: Text("Sign up")),
            ],
          ),
        ),
      ),
    );
  }
}
