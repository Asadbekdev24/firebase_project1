import 'package:flutter/material.dart';
import 'package:flutter_application_firebase_auth_project/auth_service.dart';
import 'package:flutter_application_firebase_auth_project/sign_in.dart';

class HomeScreen  extends StatelessWidget{
  const HomeScreen({super.key});

  void signOut(BuildContext context)async
  {
    AuthService authService=AuthService();

    await authService.signOut();

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignInScreen(),));
  }
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Center(child: IconButton(onPressed: (){

            signOut(context);
          }, icon: Icon(Icons.logout)),),
        ],
      ),
    );
  }
}