import 'package:flutter/material.dart';

import '../Model/datamodel.dart';
import 'catagoryFormPage.dart';
class CatagoryScreen extends StatefulWidget {
  const CatagoryScreen({super.key});

  @override
  State<CatagoryScreen> createState() => _CatagoryScreenState();
}

class _CatagoryScreenState extends State<CatagoryScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                title: Text("Right things are right behind you",style: TextStyle(color: Colors.blueGrey,fontSize: 13)),
             subtitle: Text("Category",style:  TextStyle(fontSize: 25,color: Colors.black,fontWeight: FontWeight.bold)),
                trailing: Icon(Icons.copy_all, color: Colors.black,size: 24),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0,left: 15.0,top: 10,),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: Card(
                    color: Colors.white70,
                    child: Center(
                      child: TextFormField(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CatagoryFormScreen(),));
                        },
                        decoration:   InputDecoration(
                          hintText: "  Search youe item and category....",
                          hintStyle: const TextStyle(color: Colors.blueGrey),
                          enabledBorder: InputBorder.none,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),),
                          suffixIcon: const Icon(Icons.settings_overscan,color: Colors.teal,),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 15,),
              ListTile(
                title: Text("Supreme Products",style: TextStyle(fontSize: 17)),
              ),
              // SizedBox(
              //   height: 190,
              //   child: ListView.builder(
              //     scrollDirection: Axis.horizontal,
              //
              //     itemCount: productlist1.length,
              //     itemBuilder: (BuildContext context, int index) {
              //       return   Container(
              //         margin: EdgeInsets.all(5.0),
              //         height: 190,
              //         width: MediaQuery.of(context).size.width/2.5,
              //         decoration: BoxDecoration(
              //           color:Colors.white,
              //           borderRadius: BorderRadius.circular(15),
              //           border: Border.all(color: Colors.black,),
              //
              //         ),
              //         child:  Column(
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           crossAxisAlignment: CrossAxisAlignment.center,
              //           children: [
              //             Stack(
              //               alignment:AlignmentDirectional.topEnd ,
              //               children: [
              //                 ClipRRect(
              //                   borderRadius:BorderRadius.only(
              //                     topLeft: Radius.circular(15),
              //                     topRight: Radius.circular(15),
              //                   ),
              //                   child: Image.asset("${productlist1[index].productImg}",
              //                     height: 105,
              //                     width: MediaQuery.of(context).size.width/2.5,
              //                     fit: BoxFit.fill,
              //                   ),
              //                 ),
              //
              //               ],
              //             ),
              //             Padding(
              //               padding: const EdgeInsets.only(top: 5,left: 5),
              //               child: Text("${productlist1[index].productName}",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 20)),
              //             ),
              //             SizedBox(height: 10,),
              //             Padding(
              //               padding: const EdgeInsets.only(top: 2,left: 5),
              //               child: Text("${productlist1[index].productPrice}",style: TextStyle(color: Colors.black,fontSize: 12,)),
              //             ),
              //
              //
              //           ],
              //         ),
              //       );
              //     },
              //
              //   ),
              // ),
              ListTile(
                title: Text("Animal Products",style: TextStyle(fontSize: 17)),
              ),
               ListTile(
                title: Text("Other Products",style: TextStyle(fontSize: 17)),
              ),
             ],
          ),
        ),
      ),
    );
  }
}
