import 'package:flutter/material.dart';

import '../../Model/datamodel.dart';
import '../detailsScreen.dart';
import 'exclusiveFromPage.dart';
class ExclusiveScreen extends StatefulWidget {
  const ExclusiveScreen({super.key});

  @override
  State<ExclusiveScreen> createState() => _ExclusiveScreenState();
}

class _ExclusiveScreenState extends State<ExclusiveScreen> {
  List<ProductDataModel> productlist1=[
    ProductDataModel(
      productImg: "images/avacado.jpg",
      productName: "Avacado",
      productPrice: "0.8",
    ),
    ProductDataModel(
      productImg: "images/tomato.png",
      productName: "Tomato",
      productPrice: "0.4",
    ),
    ProductDataModel(
      productImg: "images/brocly.jpeg",
      productName: "Brocoli",
      productPrice: "2.40",
    ),
    ProductDataModel(
      productImg: "images/potato.png",
      productName: "Potato",
      productPrice: "0.9",
    ),
    ProductDataModel(
      productImg: "images/splash3.jpg",
      productName: "Dry-Fruits",
      productPrice: "6.55",
    ),
    ProductDataModel(
      productImg: "images/splash4.jpg",
      productName: "Mixing-Fruits",
      productPrice: "4.11",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios,color: Colors.black)),
        actions: [ IconButton(
          icon: Icon(Icons.copy_all,color: Colors.black),
          tooltip: 'Copy',
          onPressed: () {
            // handle the press
          },
        ),],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
Padding(
  padding: const EdgeInsets.only(left: 16.0),
  child:   Text("Expulsive Offer",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 23),),
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
      Navigator.push(context, MaterialPageRoute(builder: (context) => ExpulsiveFormScreen(),));
                      },
                      decoration:   InputDecoration(
                        hintText: "  Search special items",
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

           SizedBox(
             width: MediaQuery.of(context).size.width,
             height: MediaQuery.of(context).size.height,
             child: GridView.builder(
primary: false,
               shrinkWrap: true,
               itemCount: productlist1.length,
               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                 crossAxisCount: 2,
               ),
               itemBuilder: (BuildContext context, int index) {
                 return  GestureDetector(
                   onTap: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsScreen(name: "${productlist1[index].productName}",details: "",img: "${productlist1[index].productImg}",price: "${productlist1[index].productPrice}"),));
                   },
                   child: Container(
                     margin: EdgeInsets.all(6.0),
                     height: MediaQuery.of(context).size.height/3.7,
                     width: MediaQuery.of(context).size.width,
                     decoration: BoxDecoration(
                         color: Colors.black.withOpacity(0.1),
                         borderRadius: BorderRadius.circular(15),
                         border: Border.all(color: Colors.black)
                     ),
                     child:  Column(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Stack(
                           alignment:AlignmentDirectional.topEnd ,
                           children: [
                             ClipRRect(
                               borderRadius:BorderRadius.only(
                                 topLeft: Radius.circular(15),
                                 topRight: Radius.circular(15),
                               ),
                               child: Image.asset("${productlist1[index].productImg}",
                                 height: 90,
                                  // width: MediaQuery.of(context).size.width/2.5,
                                 width: MediaQuery.of(context).size.width,
                                 fit: BoxFit.fill,
                               ),
                             ),
                             Padding(
                               padding: const EdgeInsets.all(4.0),
                               child: Icon(Icons.favorite,color: Colors.red,),
                             )
                           ],
                         ),
                         Padding(
                           padding: const EdgeInsets.only(top: 5,left: 5),
                           child: Text("${productlist1[index].productName}",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 17)),
                         ),

                         Padding(
                           padding: const EdgeInsets.only(top: 2,left: 5),
                           child: Text("Organic",style: TextStyle(color: Colors.blueGrey,fontSize: 12,)),
                         ),

                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Padding(
                               padding: const EdgeInsets.only(top: 6,left: 5),
                               child: Text("\$${productlist1[index].productPrice}",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.orange,fontSize: 18),),
                             ),
                             Padding(
                               padding: const EdgeInsets.only(right: 5,),
                               child: Container(
                                 height: 35,width: 35,
                                 decoration: BoxDecoration(
                                     shape: BoxShape.circle,
                                     color: Colors.teal
                                 ),
                                 child: Center(child: Icon(Icons.add,color: Colors.white)),
                               ),

                             ),

                           ],
                         )
                       ],
                     ),
                   ),
                 );

             },),
           )
          ],
        ),
      ),
    );
  }
}
