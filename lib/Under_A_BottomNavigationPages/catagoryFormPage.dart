import 'package:flutter/material.dart';

import '../Model/datamodel.dart';
class CatagoryFormScreen extends StatefulWidget {
  const CatagoryFormScreen({super.key});

  @override
  State<CatagoryFormScreen> createState() => _CatagoryFormScreenState();
}

class _CatagoryFormScreenState extends State<CatagoryFormScreen> {
  List<ProductDataModel> productlist1=[
    ProductDataModel(
      productImg: "images/splash2.jpg",
      productName: "Vegitables",
      productPrice: "Fresh stock  From 6.00 am",
    ),
    ProductDataModel(
      productImg: "images/splash4.jpg",
      productName: "Fruits",
      productPrice: "New stock  Every 12 hours",
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
      body: SafeArea(
         child: SingleChildScrollView(
           child: Column(
            children: [
              ListTile(
                leading: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back_ios, color: Colors.black,size: 23)),
                title: Text("Right things are right behind you",style: TextStyle(color: Colors.blueGrey,fontSize: 13)),
                subtitle: Text("Category",style:  TextStyle(fontSize: 25,color: Colors.black,fontWeight: FontWeight.bold)),
                trailing: Icon(Icons.qr_code, color: Colors.black,size: 23),
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
             ListTile(
               leading: Icon(Icons.list_alt),
               title: Text("Supreme Product",style: TextStyle(fontSize: 17)),
             ),
             ListView.builder(
               primary: false,
               shrinkWrap: true,
               itemCount: productlist1.length,
               itemBuilder: (BuildContext context, int index) { 
               return ListTile(
                 leading: CircleAvatar(

                   backgroundImage: AssetImage("${productlist1[index].productImg}"),

                 ),
                 title: Text("${productlist1[index].productName}",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,)),
                 subtitle: Text("${productlist1[index].productPrice}",style: TextStyle(color: Colors.blueGrey)),
               trailing: Icon(Icons.arrow_forward_ios,color: Colors.black),
               );
             },
               
             ),
              ListTile(
                leading: Icon(Icons.list_alt),
                title: Text("Animal Product",style: TextStyle(fontSize: 17)),
              ),
              ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: productlist1.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: CircleAvatar(

                      backgroundImage: AssetImage("${productlist1[index].productImg}"),

                    ),
                    title: Text("${productlist1[index].productName}",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,)),
                    subtitle: Text("${productlist1[index].productPrice}",style: TextStyle(color: Colors.blueGrey)),
                    trailing: Icon(Icons.arrow_forward_ios,color: Colors.black),
                  );
                },

              ),
              ListTile(
                leading: Icon(Icons.list_alt),
                title: Text("Other Product",style: TextStyle(fontSize: 17)),
              ),
              ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: productlist1.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: CircleAvatar(

                      backgroundImage: AssetImage("${productlist1[index].productImg}"),

                    ),
                    title: Text("${productlist1[index].productName}",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,)),
                    subtitle: Text("${productlist1[index].productPrice}",style: TextStyle(color: Colors.blueGrey)),
                    trailing: Icon(Icons.arrow_forward_ios,color: Colors.black),
                  );
                },

              ),

            ],
        ),
         ),
      ),
    );
  }
}
