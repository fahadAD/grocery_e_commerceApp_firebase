import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:grocery_project_firebase/Authentication/set_newPassword_Screen.dart';
import 'package:grocery_project_firebase/Authentication/signinpage.dart';
class RecoveryPassword extends StatefulWidget {
  const RecoveryPassword({super.key});

  @override
  State<RecoveryPassword> createState() => _RecoveryPasswordState();
}

class _RecoveryPasswordState extends State<RecoveryPassword> {
 final GlobalKey<FormState> _formkey=GlobalKey<FormState>();
 TextEditingController recoverEmailController=TextEditingController();
 Future<void> recoverEmailFunction()async{
   await FirebaseAuth.instance.sendPasswordResetEmail(email:  recoverEmailController.text);
   EasyLoading.showSuccess("Please Check youe mail\n Please change your forgot password");
   Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn(),));

 }
  @override
  Widget build(BuildContext context) {

    return   Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
          backgroundColor: Colors.white,
          leading: GestureDetector(
          onTap: () {
 Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn(),));
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
                  child: Text("Recover Password",style: TextStyle(color: Colors.black,fontSize: 25),),
                ),

                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text("  Enter your E-mail address to recover your password.",style: TextStyle(color: Colors.blueGrey,fontSize: 13),),


                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(right: 15.0,left: 15.0,top: 10,),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    child: Card(

                      color: Colors.white70,
                      child: Center(
                        child: TextFormField(
                          controller: recoverEmailController,
                          validator: (value) {
                            if(value!.isEmpty){
                              return "Required Email Address";
                            }else{
                              return null;
                            }
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              hintText: "Email Address",
                              hintStyle: TextStyle(color: Colors.blueGrey),
                              // focusedBorder: InputBorder.none,

                              enabledBorder: InputBorder.none,
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),),
                              prefixIcon: Icon(Icons.email_outlined,color: Colors.blueGrey,)
                          ),

                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Center(
                  child: GestureDetector(
                    onTap: () async {
                       if(_formkey.currentState!.validate()){
                         recoverEmailFunction();
                       }
                     },
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width/1.2,
                      decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(30)
                      ),
                      child: const Center(child: Text("Next",style: TextStyle(color: Colors.white,fontSize: 20))),
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
