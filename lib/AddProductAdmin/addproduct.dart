import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:grocery_project_firebase/Model/datamodel.dart';
import 'package:grocery_project_firebase/Model/ptoductmodel.dart';
import 'package:image_picker/image_picker.dart';
import '../Under_A_BottomNavigationPages/bottomNavigationbar.dart';
class AddProductADMIN extends StatefulWidget {
  const AddProductADMIN({super.key});

  @override
  State<AddProductADMIN> createState() => _AddProductADMINState();
}

class _AddProductADMINState extends State<AddProductADMIN> {
  TextEditingController _productnameController = TextEditingController();
  TextEditingController _productsalePriceController = TextEditingController();
  TextEditingController _productpursePriceController = TextEditingController();
  TextEditingController _productstockController = TextEditingController();

Future<String> imageUPload({required String path_s}) async {
  Reference ref = FirebaseStorage.instance.ref().child("AllProductFolder/${DateTime.now().toString()}");
var stringPath= await ref.putFile(File(path_s));
 return stringPath.ref.getDownloadURL();
}

  Future<void> addProductPost_data_SetupFun({required ProductModel user_ProductModel})async{
    CollectionReference usersproduct_Data=FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser?.uid??"").doc("AllproductS").collection("product");
    await  usersproduct_Data.add(user_ProductModel.toJson());
    EasyLoading.showSuccess("Upload done");
  }
  ImagePicker pick_Image=ImagePicker();
  String? imagePath;
  var _image;
  @override
  Widget build(BuildContext context) {
    return   SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
              // onTap: () {
              //   Navigator.pop(context);
              // },
              child: Icon(Icons.arrow_back_outlined)),
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text("AdminPanel",style: TextStyle(color: Colors.black)),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [

              Padding(
                padding: const EdgeInsets.only(right: 15.0,left: 15.0,top: 10,),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: Card(

                    color: Colors.white70,
                    child: Center(
                      child: TextFormField(

                        controller: _productnameController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            hintText: "Enter your Product name",
                            hintStyle: const TextStyle(color: Colors.blueGrey),
                            enabledBorder: InputBorder.none,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),),
                            prefixIcon: const Icon(Icons.grass,color: Colors.blueGrey,)
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

                        controller: _productsalePriceController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            hintText: "Enter your Product Sale Price",
                            hintStyle: const TextStyle(color: Colors.blueGrey),
                            enabledBorder: InputBorder.none,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),),
                            prefixIcon: const Icon(Icons.money,color: Colors.blueGrey,)
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

                        controller: _productpursePriceController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            hintText: "Enter your Product Purse Price",
                            hintStyle: const TextStyle(color: Colors.blueGrey),
                            enabledBorder: InputBorder.none,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),),
                            prefixIcon: const Icon(Icons.monetization_on_outlined,color: Colors.blueGrey,)
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

                        controller: _productstockController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            hintText: "Enter your Stock",
                            hintStyle: const TextStyle(color: Colors.blueGrey),
                            enabledBorder: InputBorder.none,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),),
                            prefixIcon: const Icon(Icons.production_quantity_limits,color: Colors.blueGrey,)
                        ),
                      ),
                    ),
                  ),
                ),
              ),


GestureDetector(
  onTap: () async {
 var I = await pick_Image.pickImage(source: ImageSource.gallery);
setState(() {
  imagePath=I?.path??"";
});
  },
  child:   Container(
    height: 150,
    width: 250,
    decoration: BoxDecoration(

      borderRadius: BorderRadius.circular(16),

      border: Border.all(color: Colors.black)

    ),
child:imagePath==null?Padding(
  padding: const EdgeInsets.all(8.0),
  child:   ClipRRect(
    borderRadius: BorderRadius.circular(16),
    child: Image.asset("images/slider4.jpg",fit: BoxFit.cover,height: 140,

      width: 240,),
  ),
)
    :
Image.file(File(imagePath??""),fit: BoxFit.fill),
  ),
),
              SizedBox(height: 20,),
              Center(
                child: GestureDetector(
                  onTap: () async {
                 imagePath=await imageUPload(path_s: imagePath??"");
                     ProductModel _ProfileModel=ProductModel(
                        productID: Timestamp.now().millisecondsSinceEpoch,
                        productImagE:  imagePath??"",
                        productNamE: _productnameController.text,
                        productStocK: int.tryParse(_productstockController.text)??0,
                        purchasePricE: double.tryParse(_productpursePriceController.text)??0,
                        salePricE: double.tryParse(_productsalePriceController.text)??0,
                         isFav: false
                    );
                    addProductPost_data_SetupFun(user_ProductModel:  _ProfileModel);
                    _productsalePriceController.clear();
                    _productpursePriceController.clear();
                    _productstockController.clear();
                    _productnameController.clear();
                     Navigator.push(context, MaterialPageRoute(builder:  (context) => BottomNavigationBars(),));
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
    );
  }
}
