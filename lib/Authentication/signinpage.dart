import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:grocery_project_firebase/Authentication/recovery_passrord_screen.dart';
import 'package:grocery_project_firebase/Authentication/signuppage.dart';
import 'package:grocery_project_firebase/Under_A_BottomNavigationPages/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Under_A_BottomNavigationPages/bottomNavigationbar.dart';
import '../userform.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool _obscureText = true;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _switch = false;
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  Future<void> logINFunction() async {
    if (loginEmailController.text != '' && loginPasswordController.text != '') {
      if (loginEmailController.text.contains("@") &&
          loginEmailController.text.contains(".com")) {
        try {
          EasyLoading.show(status: "Loding...");
          var auth = FirebaseAuth.instance;
          UserCredential user = await auth.signInWithEmailAndPassword(
              email: loginEmailController.text,
              password: loginPasswordController.text);
          if (user.user != null) {
            if (_switch) {
              await setRemenberMe(
                e_mail: loginEmailController.text,
                password: loginPasswordController.text,
              );
            }
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserForm(),
                ));
            EasyLoading.showSuccess("Login Successful Done");
            // if(user.additionalUserInfo?.isNewUser??false){
            //   Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => UserForm(),
            //       ));
            // }
            // else{
            //   Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => BottomNavigationBars(),
            //       ));
            // }
          } else {
            EasyLoading.showError("Something is wrong");
          }
        } on FirebaseAuthException catch (e) {
          EasyLoading.showError(e.code);
        } catch (e) {
          EasyLoading.showError(e.toString());
        }
      } else {
        EasyLoading.showError("Enter a valid email");
      }
    } else {
      EasyLoading.showError("Required email & password");
    }
  }

  Future<void> googleLogINFunction() async {
    EasyLoading.show(status: "Loding...");

    final GoogleSignInAccount? _googleSignInAccount_user = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? _googleauth = await _googleSignInAccount_user?.authentication;

    final _crediental = GoogleAuthProvider.credential(accessToken: _googleauth?.accessToken, idToken: _googleauth?.idToken);
    UserCredential users = await FirebaseAuth.instance.signInWithCredential(_crediental);

    if (users.user != null) {
      EasyLoading.showSuccess("Google Login Succesfuliy Done ");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => UserForm()));
    } else {
      EasyLoading.showError("Something is wrong");
    }
  }

  Future<void> setRemenberMe({required String e_mail, required String password}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_email', e_mail);
    await prefs.setString('user_password', password);
  }

  Future<void> getRemenberMe() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _switch = prefs.getBool("userSwitch") ?? false;
      if (_switch) {
        loginEmailController.text = prefs.getString("user_email") ?? '';
        loginPasswordController.text = prefs.getString("user_password") ?? '';
      }
      // isREMB: _switch
    });
  }

  @override
  void initState() {
    super.initState();
    getRemenberMe();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    loginPasswordController.dispose();
    loginEmailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Don't have an account?    ",
                style: TextStyle(color: Colors.black)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Signup(),
                      ));
                },
                child: const Text("Sign up",
                    style: TextStyle(
                        color: Colors.teal,
                        fontWeight: FontWeight.bold,
                        fontSize: 15))),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                const Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 35,
                    backgroundImage: AssetImage(
                      "images/splash1.jpg",
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Welcome back!",
                    style: TextStyle(color: Colors.black, fontSize: 25),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(3.0),
                  child: Text(
                    "Sign in to your account",
                    style: TextStyle(color: Colors.blueGrey, fontSize: 13),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 15.0,
                    left: 15.0,
                    top: 10,
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    child: Card(
                      color: Colors.white70,
                      child: Center(
                        child: TextFormField(
                          controller: loginEmailController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Required Email Address";
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              hintText: "Email Address",
                              hintStyle:
                                  const TextStyle(color: Colors.blueGrey),
                              enabledBorder: InputBorder.none,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              prefixIcon: const Icon(
                                Icons.email_outlined,
                                color: Colors.blueGrey,
                              )),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 15.0,
                    left: 15.0,
                    top: 10,
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    child: Card(
                      color: Colors.white70,
                      child: Center(
                        child: TextFormField(
                          obscureText: _obscureText,
                          controller: loginPasswordController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Required Password";
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "Password",
                            hintStyle: const TextStyle(color: Colors.blueGrey),
                            enabledBorder: InputBorder.none,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            prefixIcon: const Icon(
                              Icons.lock_outlined,
                              color: Colors.blueGrey,
                            ),
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
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CupertinoSwitch(
                          value: _switch,
                          onChanged: (value) async {
                            setState(() {
                              _switch = value;
                            });
                            final SharedPreferences prefs = await SharedPreferences.getInstance();
                            await prefs.setBool("userSwitch", value);
                          },
                        ),
                        Text(
                          "Remember me",
                          style: TextStyle(color: Colors.blueGrey),
                        ),
                      ],
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RecoveryPassword(),
                              ));
                        },
                        child: Text(
                          "Forgot Password",
                          style: TextStyle(
                              color: Colors.teal, fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    if (_formkey.currentState!.validate()) {
                      logINFunction();
                    }
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 1.1,
                    decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(30)),
                    child: const Center(
                        child: Text("Login",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20))),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    const Divider(
                        color: Colors.blueGrey,
                        thickness: 2,
                        endIndent: 20,
                        indent: 20),
                    Container(
                      height: 30,
                      width: 30,
                      decoration: const BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                      child: const Center(
                          child: Text("OR",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold))),
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        EasyLoading.showSuccess("Login Succesfuliy Done ");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserForm()));
                      },
                      child: CircleAvatar(
                        radius: 17,
                        backgroundImage: AssetImage("images/apple.webp"),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        EasyLoading.showSuccess("Login Succesfuliy Done ");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserForm()));
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 20,
                        backgroundImage: AssetImage("images/facebook.png"),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        googleLogINFunction();
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
