import 'package:flutter/material.dart';
import 'package:grocery_project_firebase/Authentication/recovery_passrord_screen.dart';
 class SetNewPassword extends StatefulWidget {
  const SetNewPassword({super.key});

  @override
  State<SetNewPassword> createState() => _SetNewPasswordState();
}

class _SetNewPasswordState extends State<SetNewPassword> {
final  GlobalKey<FormState> _formkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    return   Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => RecoveryPassword(),));
              },
              child: Icon(Icons.arrow_back_ios,color: Colors.black,))),
      body: SafeArea(
        child: SingleChildScrollView(

          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Set new password",style: TextStyle(color: Colors.black,fontSize: 25),),
                ),

                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text("  Your new password must be different from previously used\n  password",style: TextStyle(color: Colors.blueGrey,fontSize: 13),),


                ),
                SizedBox(height: 20,),
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
                              return "Required A New Password";
                            }else{
                              return null;
                            }
                          },
                          keyboardType: TextInputType.number,
                          decoration:   InputDecoration(
                            hintText: "New Password",
                            hintStyle: const TextStyle(color: Colors.blueGrey),
                            enabledBorder: InputBorder.none,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),),
                            prefixIcon: const Icon(Icons.lock_outlined,color: Colors.blueGrey,),
                            suffixIcon: const Icon(Icons.remove_red_eye_outlined,color: Colors.black,),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
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
                              return "Required A Confirm Password";
                            }else{
                              return null;
                            }
                          },
                          keyboardType: TextInputType.number,
                          decoration:   InputDecoration(
                            hintText: "Confirm Password",
                            hintStyle: const TextStyle(color: Colors.blueGrey),
                            enabledBorder: InputBorder.none,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),),
                            prefixIcon: const Icon(Icons.lock_outlined,color: Colors.blueGrey,),
                            suffixIcon: const Icon(Icons.remove_red_eye_outlined,color: Colors.black,),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      if(_formkey.currentState!.validate()){

                      }
                    },
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width/1.2,
                      decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(30)
                      ),
                      child: const Center(child: Text("Change Password",style: TextStyle(color: Colors.white,fontSize: 20))),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
