import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:grocery_project_firebase/Authentication/signinpage.dart';
import '../userform.dart';
 class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool _obscureText = true;
 final  GlobalKey<FormState> _formkey=GlobalKey<FormState>();
 bool _check=false;
 TextEditingController signupNameController=TextEditingController();
 TextEditingController signupEmailController=TextEditingController();
 TextEditingController signupPasswordController=TextEditingController();
    Future<void> signUPFunction()async{
      if(signupEmailController.text != '' &&  signupPasswordController.text != ''){
        if(signupEmailController.text.contains("@") && signupEmailController.text.contains(".com")){
          try{
            EasyLoading.show(status: "Loding...");
            var auth=FirebaseAuth.instance;
            UserCredential user=await auth.createUserWithEmailAndPassword(email: signupEmailController.text, password: signupPasswordController.text);
            if(user.user != null){
              EasyLoading.showSuccess("Signup Successful Done\n Now Then Login");
              Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn(),));
            }else{
              EasyLoading.showError("Something is wrong");
            }
          }on FirebaseAuthException catch (e) {
            if (e.code == 'weak-password') {
              EasyLoading.showError('The password provided is too weak.');
            }
            else if (e.code == 'email-already-in-use') {
              EasyLoading.showError('The account already exists for that email.');
            }
          }catch(e){
            EasyLoading.showError(e.toString());

          }
        }else{
          EasyLoading.showError("Enter a valid email");
        }
      }else{
        EasyLoading.showError("Required email & password");
      }
    }
 Future<void> googleSignUPFunction()async{
   EasyLoading.show(status: "Loding...");
   final GoogleSignInAccount? _googleSignInAccount_user=await GoogleSignIn().signIn();
   final GoogleSignInAuthentication?  _googleauth=await _googleSignInAccount_user?.authentication;

   final _crediental=GoogleAuthProvider.credential(accessToken: _googleauth?.accessToken, idToken: _googleauth?.idToken);
   UserCredential users= await FirebaseAuth.instance.signInWithCredential(_crediental);
   if(users.user != null){
     EasyLoading.showSuccess("Google Signup Succesfuliy Done ");
     Navigator.push(context, MaterialPageRoute( builder: (context) =>  UserForm()));
   }else{
     EasyLoading.showError("Something is wrong");
   }
 }
 @override
 void dispose() {
   // TODO: implement dispose
   super.dispose();
   signupEmailController.dispose();
   signupPasswordController.dispose();
 }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
       bottomNavigationBar:Row(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           const Padding(
             padding: EdgeInsets.all(8.0),
             child: Text("Already have an acccount?    ",style: TextStyle(color: Colors.black)),
           ),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: GestureDetector(
                 onTap: () {
Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn(),));
                 },
                 child: const Text("Log in",style: TextStyle(color: Colors.teal,fontWeight: FontWeight.bold,fontSize: 15))),
           ),


         ],
       ),
       body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
               children: [
const SizedBox(height: 15,),
                 const Center(
                   child: CircleAvatar(

                     backgroundColor: Colors.white,
                     radius: 35,
                     backgroundImage:  AssetImage("images/splash1.jpg",),
                   ),
                 ),
                 const SizedBox(height: 5,),
                 const Padding(
                   padding: EdgeInsets.all(8.0),
                   child: Text("Let's get started",style: TextStyle(color: Colors.black,fontSize: 25),),
                 ),

                 const Padding(
                   padding: EdgeInsets.all(3.0),
                   child: Text("Please enter your valid data in order to create an account",style: TextStyle(color: Colors.blueGrey,fontSize: 13),),
                 ),
                 const SizedBox(height: 10,),
                 Padding(
                   padding: const EdgeInsets.only(right: 15.0,left: 15.0,top: 10,),
                   child: ClipRRect(
                     borderRadius: const BorderRadius.all(Radius.circular(20)),
                     child: Card(
                       color: Colors.white70,
                       child: Center(
                         child: TextFormField(
                           // controller: signupNameController,
                           validator: (value) {
                             if(value!.isEmpty){
                               return "Required A Name";
                             }else{
                               return null;
                             }
                           },
                           keyboardType: TextInputType.name,
                           decoration:   InputDecoration(
                               hintText: "Full Name",
                               hintStyle: const TextStyle(color: Colors.blueGrey),
                               enabledBorder: InputBorder.none,
                               border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),),
                               prefixIcon: const Icon(Icons.person,color: Colors.blueGrey,)
                           ),
                         ),
                       ),
                     ),
                   ),
                 ),
                 Padding(
                   padding:   const EdgeInsets.only(right: 15.0,left: 15.0,top: 10,),
                   child: ClipRRect(
                     borderRadius:   const BorderRadius.all(Radius.circular(20)),
                     child: Card(
                       color: Colors.white70,
                       child: Center(
                         child: TextFormField(
                           controller: signupEmailController,
                           validator: (value) {
                             if(value!.isEmpty){
                               return "Required A Email Address";
                             }else{
                               return null;
                             }
                           },
                           keyboardType: TextInputType.emailAddress,
                           decoration:   InputDecoration(
                               hintText: "Email Address",
                               hintStyle: const TextStyle(color: Colors.blueGrey),
                               enabledBorder: InputBorder.none,
                               border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),),
                               prefixIcon: const Icon(Icons.email_outlined,color: Colors.blueGrey,)
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
                           obscureText: _obscureText,
                           controller: signupPasswordController,
                           validator: (value) {
                             if(value!.isEmpty){
                               return "Required A Password";
                             }else{
                               return null;
                             }
                           },
                           keyboardType: TextInputType.number,
                           decoration:   InputDecoration(
                               hintText: "Password",
                               hintStyle: const TextStyle(color: Colors.blueGrey),
                             enabledBorder: InputBorder.none,
                             border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),),
                               prefixIcon: const Icon(Icons.lock_outlined,color: Colors.blueGrey,),
                             suffixIcon: _obscureText == false
                                 ? IconButton(
                                 onPressed: () {
                                   setState(() {
                                     _obscureText = true;
                                   });
                                 },
                                 icon: Icon(
                                   Icons.remove_red_eye,
                                   color: Colors.black,
                                 ))
                                 : IconButton(
                                 onPressed: () {
                                   setState(() {
                                     _obscureText = false;
                                   });
                                 },
                                 icon: Icon(
                                   Icons.visibility_off,
                                   color: Colors.black,
                                 )),
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
                           obscureText: _obscureText,
                           // controller: signupPasswordController,
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
                             suffixIcon: _obscureText == false
                                 ? IconButton(
                                 onPressed: () {
                                   setState(() {
                                     _obscureText = true;
                                   });
                                 },
                                 icon: Icon(
                                   Icons.remove_red_eye,
                                   color: Colors.black,
                                 ))
                                 : IconButton(
                                 onPressed: () {
                                   setState(() {
                                     _obscureText = false;
                                   });
                                 },
                                 icon: Icon(
                                   Icons.visibility_off,
                                   color: Colors.black,
                                 )),                           ),
                         ),
                       ),
                     ),
                   ),
                 ),
                 const SizedBox(height: 10,),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: [
                   CupertinoCheckbox(value: _check, onChanged: (value) {

 setState(() {
   _check=value!;
 });
                  },),
                   RichText(
                     text: const TextSpan(
                       text: 'I agree with the',
                       style: TextStyle(color: Colors.black,fontSize: 12),
                       children: <TextSpan>[
                          TextSpan(text: ' Terms and Services', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.teal)),
                         TextSpan(text: ' & privacy\n policy', style: TextStyle(fontWeight: FontWeight.normal)),

                       ],
                     ),
                   )
                 ],),
                 const SizedBox(height: 8,),
                 GestureDetector(
                   onTap:_check ? ()async {
                     if(_formkey.currentState!.validate()){
                       signUPFunction();
                      }
                   }:(){
                     EasyLoading.showError("Please Check Box.\n Do you agree or disagree\n terms and condition");
                   },
                   child: Container(
                     height: 50,
                     width: MediaQuery.of(context).size.width/1.1,
                     decoration: BoxDecoration(
                       color: Colors.teal,
                       borderRadius: BorderRadius.circular(30)
                     ),
                     child: const Center(child: Text("Continue",style: TextStyle(color: Colors.white,fontSize: 20))),
                   ),
                 ),
const SizedBox(height: 10,),
                 Stack(
                   alignment: AlignmentDirectional.center,
                   children: [
                     const Divider(color: Colors.blueGrey,thickness: 2,endIndent: 20,indent: 20),
                     Container(
                       height: 30,width: 30,
                       decoration: const BoxDecoration(
                         color: Colors.white,
                          shape: BoxShape.circle
                       ),
                       child: const Center(child: Text("OR",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold))),
                     )
                   ],
                 ),
                 const SizedBox(height: 10,),
  Row(
   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    GestureDetector(
      onTap: () {
        EasyLoading.showSuccess("Signup Succesfuliy Done");
        Navigator.push(context, MaterialPageRoute( builder: (context) =>  UserForm()));
      },
      child: CircleAvatar(
        radius: 17,

         backgroundImage: AssetImage("images/apple.webp"),
      ),
    ),
    GestureDetector(
      onTap: () {
        EasyLoading.showSuccess(" Signup Succesfuliy Done ");
        Navigator.push(context, MaterialPageRoute( builder: (context) =>  UserForm()));
      },
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 20,
        backgroundImage: AssetImage("images/facebook.png"),
      ),
    ),
    GestureDetector(
      onTap: () {
        googleSignUPFunction();
      },
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 20,
        backgroundImage: AssetImage("images/google.png"),
      ),
    ),

  ],
)

              ],
            ),
          ),
        ),
      ),
    );
  }
}
