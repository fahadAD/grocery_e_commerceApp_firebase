import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_project_firebase/Provider/allProvider.dart';
import 'package:provider/provider.dart';
class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Icon(Icons.yard),
        backgroundColor: Colors.white,
        elevation: 0,
         centerTitle: true,
         title: Text("Profile",style: TextStyle(color: Colors.black)),
      ),
      body: Consumer<ProfileProvider>(builder: (context, value, child) {
return value.isloding? Center(child: CircularProgressIndicator()): Center(
  child:   SingleChildScrollView(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
SizedBox(height: 100,),
        Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none,
         children: [
           Center(
             child: Container(
                decoration: BoxDecoration(
                  color: Colors.teal,
borderRadius: BorderRadius.circular(20),
                  // border: Border.all(color: Colors.black),

                ),
               margin: EdgeInsets.all(5),
               width: MediaQuery.of(context).size.width*0.9,
               height: MediaQuery.of(context).size.height/1.6,
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.center,
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [

                   ListTile(
                     leading: Icon(Icons.person,color: Colors.white,size: 30),
                     title: Text(value.profile.name??"",style: GoogleFonts.aboreto(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold,letterSpacing: 1),),
                   ),
                   ListTile(
                     leading: Icon(Icons.call,color: Colors.white,size: 30),
                     title: Text(value.profile.number??"",style: GoogleFonts.lobster(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold,letterSpacing: 1),),
                   ),
                   ListTile(
                     leading: Icon(Icons.date_range_sharp,color: Colors.white,size: 30),
                     title: Text(value.profile.dateofbith??"",style: GoogleFonts.aboreto(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold,letterSpacing: 1),),
                   ),
                   ListTile(
                     leading: Icon(Icons.people_outlined,color: Colors.white,size: 30),
                     title: Text(value.profile.gender??"",style: GoogleFonts.aBeeZee(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold,letterSpacing: 1),),
                   ),
                   ListTile(
                     leading: Icon(Icons.cake_outlined,color: Colors.white,size: 30),
                     title: Text(value.profile.age??"",style: GoogleFonts.abel(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold,letterSpacing: 1),),
                   ),
                   ListTile(
                     leading: Icon(Icons.edit_location_alt,color: Colors.white,size: 30),
                     title: Text(value.profile.landmark??"",style: GoogleFonts.alata(color: Colors.white,fontSize: 20,letterSpacing: 1),),
                   ),
                 ],
               ),
             ),
           ),

           Positioned(
             top: -90,
             // left: 80,
             child: Provider.of<ProfileProvider>(context).profile.isAdmin??false?Container(

               height: 150,
               width: 150,
               decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.teal,),
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   Center(child: Icon(Icons.add_moderator,size: 50,color: Colors.orangeAccent,)),
                   SizedBox(height: 10,),
                   Center(child: Text("Admin/Owner",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 16))),
                 ],
               ),
             ):CircleAvatar(
               backgroundColor: Colors.white,
               backgroundImage: NetworkImage(FirebaseAuth.instance.currentUser?.photoURL??""),
               radius: 70,
             ),
           ),
         ],
       )


      ],
    ),
  ),
);
      },),
    );
  }
}
