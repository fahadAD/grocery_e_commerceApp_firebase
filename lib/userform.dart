import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:grocery_project_firebase/Model/profile-model.dart';
import 'package:provider/provider.dart';

import 'Under_A_BottomNavigationPages/bottomNavigationbar.dart';

class UserForm extends StatefulWidget {
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  bool _adminswitch=false;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _landmarkController = TextEditingController();
  List<String> gender = ["Male", "Female", "Other"];

  Future<void> _selectDateFromPicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(DateTime.now().year - 20),
      firstDate: DateTime(DateTime.now().year - 30),
      lastDate: DateTime(DateTime.now().year),
    );
    if (picked != null)
      setState(() {
        _dobController.text = "${picked.day}/ ${picked.month}/ ${picked.year}";
      });
  }

final GlobalKey<FormState> _form=GlobalKey<FormState>();


 Future<void> userFormPost_data_SetupFun({required ProfileModel user_ProfileModel})async{
   DocumentReference usersform_Data=FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser?.uid??"").doc("profileS");
await  usersform_Data.set(user_ProfileModel.toJson());
    EasyLoading.showSuccess("Profile Setup Successful done");

 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
              key: _form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Submit the form to continue.",
                    style:
                    TextStyle(fontSize: 22, color: Colors.deepOrange),
                  ),
                  Text(
                    "We will not share your information with anyone.",
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xFFBBBBBB),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),


                  Padding(
                    padding: const EdgeInsets.only(right: 15.0,left: 15.0,top: 10,),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      child: Card(

                        color: Colors.white70,
                        child: Center(
                          child: TextFormField(
                            validator: (value) {
                              if(value!.isEmpty){
                                return "Required Name ";
                              }else{
                                return null;
                              }
                            },
                            controller: _nameController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                hintText: "Enter your name",
                                hintStyle: const TextStyle(color: Colors.blueGrey),
                                enabledBorder: InputBorder.none,
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),),
                                prefixIcon: const Icon(Icons.person_pin,color: Colors.blueGrey,)
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // SizedBox(height: 6,),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0,left: 15.0,top: 10,),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      child: Card(

                        color: Colors.white70,
                        child: Center(
                          child: TextFormField(
                            validator: (value) {
                              if(value!.isEmpty){
                                return "Required Number ";
                              }else{
                                return null;
                              }
                            },
                            controller: _phoneController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                hintText: "Enter your nymber",
                                hintStyle: const TextStyle(color: Colors.blueGrey),
                                enabledBorder: InputBorder.none,
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),),
                                prefixIcon: const Icon(Icons.phone,color: Colors.blueGrey,)
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 6,),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                    child: TextFormField(
                      controller: _dobController,
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: "date of birth",
                        suffixIcon: IconButton(
                          onPressed: () => _selectDateFromPicker(context),
                          icon: Icon(Icons.calendar_today_outlined),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 6,),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                    child: TextField(
                      controller: _genderController,
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: "choose your gender",
                        prefixIcon: DropdownButton<String>(
                          items: gender.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                              onTap: () {
                                setState(() {
                                  _genderController.text = value;
                                });
                              },
                            );
                          }).toList(),
                          onChanged: (_) {},
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(right: 15.0,left: 15.0,top: 10,),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      child: Card(

                        color: Colors.white70,
                        child: Center(
                          child: TextFormField(
                            validator: (value) {
                              if(value!.isEmpty){
                                return "Required Age ";
                              }else{
                                return null;
                              }
                            },
                            controller: _ageController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                hintText: "Enter your age",
                                hintStyle: const TextStyle(color: Colors.blueGrey),
                                enabledBorder: InputBorder.none,
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),),
                                prefixIcon: const Icon(Icons.date_range_outlined,color: Colors.blueGrey,)
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0,left: 15.0,top: 10,),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      child: Card(

                        color: Colors.white70,
                        child: Center(
                          child: TextFormField(
                            validator: (value) {
                              if(value!.isEmpty){
                                return "Required LandMark ";
                              }else{
                                return null;
                              }
                            },
                            controller: _landmarkController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                hintText: "Enter your LandMark",
                                hintStyle: const TextStyle(color: Colors.blueGrey),
                                enabledBorder: InputBorder.none,
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),),
                                prefixIcon: const Icon(Icons.add_location_outlined,color: Colors.blueGrey,)
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),


              Row(
                children: [
                  CupertinoSwitch(value: _adminswitch, onChanged: (value) {
                    setState(() {
                      _adminswitch=value;
                    });
                  },),
                  Text("Are you admin then click switch")
                ],
              )    ,
                  SizedBox(
                    height: 100,
                  ),

                  // elevated button


                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder:  (context) => BottomNavigationBars(),));

                        if(_form.currentState!.validate()){
                          ProfileModel _ProfileModel=ProfileModel(
                              name: _nameController.text,
                              age : _ageController.text,
                              dateofbith: _dobController.text,
                              gender:  _genderController.text,
                              landmark:   _landmarkController.text,
                              number: _phoneController.text,
                            isAdmin: _adminswitch,
                          );
                          userFormPost_data_SetupFun(user_ProfileModel: _ProfileModel);
                          _nameController.clear();
                          _phoneController.clear();
                          _ageController.clear();
                          _dobController.clear();
                          _genderController.clear();
                          _landmarkController.clear();
                         }
                       },
                      child: Container(
                        width: MediaQuery.of(context).size.width*0.7,
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(child: Text("Continue",style: TextStyle(color: Colors.white,fontSize: 25))),



                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}