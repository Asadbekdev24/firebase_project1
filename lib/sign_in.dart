import 'package:flutter/material.dart';
import 'package:flutter_application_firebase_auth_project/auth_service.dart';
import 'package:flutter_application_firebase_auth_project/home_screen.dart';
import 'package:flutter_application_firebase_auth_project/sign_up.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen  extends StatefulWidget{


  const SignInScreen({super.key});

  @override

  State<SignInScreen> createState()=> _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>{

  final TextEditingController email=TextEditingController();
  final TextEditingController password=TextEditingController();
  final AuthService _authService=AuthService();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    email.dispose();
    password.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [

              SizedBox(height: 32,),
             TextFormField(

              keyboardType: TextInputType.emailAddress,
              controller: email,
              decoration: InputDecoration(
                hintText: "Enter your email",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),

              ),
             ),

             SizedBox(height: 32,),
             TextFormField(
              decoration: InputDecoration(
                hintText: "Enter your password",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              ),
              controller: password,
              keyboardType: TextInputType.number,

             ),

             SizedBox(height: 32,),

             ElevatedButton(onPressed: () async{

             final javob= await _authService.signIn(email.text.trim(), password.text.trim());

             final SharedPreferences preferences= await SharedPreferences.getInstance();

             if(javob!=null)
             {
              print("ok yaxshi");
              preferences.setString("user", javob.uid);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(userId: javob.uid,),));
             }else
             {
              print("yomon");
             }
             }, child: Text("Sign In")),

             SizedBox(height: 32,),
             TextButton(onPressed: (){

              Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen(),));
             }, child: Text("Don't have Account, Sign Up")),
            ],
          ),
        ),
      ),
    );
  }
}