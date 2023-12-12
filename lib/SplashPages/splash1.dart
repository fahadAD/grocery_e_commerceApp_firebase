import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_project_firebase/Authentication/signuppage.dart';
import 'package:grocery_project_firebase/SplashPages/splash2.dart';
import '../userform.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    nextPage();
  }
  void nextPage()async{
  await Future.delayed(const Duration(seconds: 7),);
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SplashScreen1(),));
  // if(FirebaseAuth.instance.currentUser !=null){
  //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => UserForm(),));
  // }else{
  //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SplashScreen1(),));
  // }
  }
  @override
  Widget build(BuildContext context) {
     return     Scaffold(
      backgroundColor: Colors.teal,
      body: SafeArea(
        child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Center(
              child: CircleAvatar(

                backgroundColor: Colors.white,
                 radius: 60,
                backgroundImage:  AssetImage("images/splash1.jpg"),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
