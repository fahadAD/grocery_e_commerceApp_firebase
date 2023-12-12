import 'package:flutter/material.dart';

import '../Authentication/signuppage.dart';
class SplashScreen3 extends StatelessWidget {
  const SplashScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:   GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Signup(),));
        },
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width/3,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.teal,width: 3)
              ),
            ),
            Container(
              height: 45,
              width: MediaQuery.of(context).size.width/3.5,
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(30),

              ),
              child: Icon(Icons.arrow_forward,color: Colors.white,size: 25),
            ),

          ],
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(

            children: [
              Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  ClipPath(
                    clipper: clip1Cliper(),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 1.5,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                "images/splash4.jpg",
                              ),
                              fit: BoxFit.fitHeight)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Signup(),));

                      },
                      child: Container(
                        height: 35,width: 70,
                        decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(30)),
                        child: const Center(child: Text("Skip",style: TextStyle(color: Colors.black,fontSize: 20))),
                      ),
                    ),
                  )
                ],
              ),
              Text(
                "Easy and online",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 27,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                " payment",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 27,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 17,
              ),
              Text(
                "Trouble free and online payment",
                style: TextStyle(
                  color: Colors.blueGrey,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              const Text(
                "any card payment is avaliable",
                style: TextStyle(
                  color: Colors.blueGrey,
                ),
              ),




            ],
          ),
        ),
      ),
    );
  }
}

class clip1Cliper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    // path.lineTo(size.width, size.height);
    path.quadraticBezierTo(
        size.width * 0.5, size.height - 80, size.width, size.height);
    path.lineTo(size.width, 0);
// path.quadraticBezierTo(0, size.height, 0, 0);
//     path.quadraticBezierTo(0, 0, 0, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
