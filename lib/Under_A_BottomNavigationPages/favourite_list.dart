import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_project_firebase/Provider/allProvider.dart';
import 'package:provider/provider.dart';

import '../Model/datamodel.dart';
import '../Model/ptoductmodel.dart';
import 'detailsScreen.dart';
class WishList extends StatefulWidget {
  const WishList({super.key});

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {

  Future<void> delete_Fav({required ProductModel product, required bool values}) async {
    DocumentReference f = FirebaseFirestore.instance
        .collection(FirebaseAuth.instance.currentUser?.uid ?? "")
        .doc("AllproductS")
        .collection("product")
        .doc(product.databaseKey);
    await f.update({
      "isFav": values,
    });

    Provider.of<ProductProvider>(context, listen: false).updateProducts();
    // Provider.of<ProductProvider>(context,listen: false).getFavouriteProducts();

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ProductProvider>(context,listen: false).getFavouriteProducts();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Icon(Icons.add),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("Wishlist",style: TextStyle(color: Colors.black)),
      ),
      // body:ListView.builder(
      //   primary: false,
      //   shrinkWrap: true,
      //   itemCount: productlist1.length,
      //   itemBuilder: (BuildContext context, int index) {
      //     return Padding(
      //       padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 6),
      //       child:   GestureDetector(
      //         onTap: () {
      //           Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsScreen(name: "${productlist1[index].productName}",details: "",img: "${productlist1[index].productImg}",price: "${productlist1[index].productPrice}"),));
      //         },
      //         child: Container(
      //           height: 100,
      //           width: MediaQuery.of(context).size.width,
      //           decoration: BoxDecoration(
      //               borderRadius: BorderRadius.circular(15),
      //
      //               border: Border.all(color: Colors.black)
      //           ),
      //           child: Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               Row(
      //
      //                 children: [
      //                   SizedBox(width: 10,),
      //                   CircleAvatar(
      //                     backgroundColor: Colors.white,
      //                     radius: 30,
      //                     backgroundImage: AssetImage("${productlist1[index].productImg}"),
      //                   ),
      //                   SizedBox(width: 15,),
      //                   Column(
      //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //                     crossAxisAlignment: CrossAxisAlignment.start,
      //                     children: [
      //                       Text("${productlist1[index].productName}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
      //                       Text("Organic",style: TextStyle( color: Colors.blueGrey)),
      //                       Column(
      //                         crossAxisAlignment: CrossAxisAlignment.start,
      //                         mainAxisAlignment: MainAxisAlignment.end,
      //                         children: [
      //                           Text("\$${productlist1[index].productPrice}",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red,fontSize: 18)),
      //
      //                         ],
      //                       )
      //                     ],
      //                   ),
      //                 ],
      //               ),
      //               Column(
      //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //                 children: [
      //                   Icon(Icons.favorite,color: Colors.red,size: 25,),
      //                   Padding(
      //                     padding: const EdgeInsets.only(right: 5,),
      //                     child: Container(
      //                       height: 35,width: 35,
      //                       decoration: BoxDecoration(
      //                           shape: BoxShape.circle,
      //                           color: Colors.teal
      //                       ),
      //                       child: Center(child: Icon(Icons.add,color: Colors.white)),
      //                     ),
      //
      //                   ),
      //                 ],
      //               )
      //             ],
      //           ),
      //         ),
      //       ),
      //     );
      //   },
      //
      // ),
      body:Consumer<ProductProvider>(builder: (context, value, child) {
        return ListView.builder(
          primary: false,
          shrinkWrap: true,
          itemCount: value.favProducts.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 6),
              child:   Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),

                    border: Border.all(color: Colors.black)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>   DetailsScreen(all_products_data: value.favProducts[index],)));

                      },
                      child: Row(

                        children: [
                          SizedBox(width: 10,),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>   DetailsScreen(all_products_data: value.favProducts[index],)));

                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 30,
                              backgroundImage: NetworkImage("${value.favProducts[index].productImagE}"),
                            ),
                          ),
                          SizedBox(width: 15,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${value.favProducts[index].productNamE}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                              Text("Organic",style: TextStyle( color: Colors.blueGrey)),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text("\$${value.favProducts[index].salePricE}",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red,fontSize: 18)),

                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 5,),
                      child: GestureDetector(
                        onTap: () async {
                          await  delete_Fav(product: value.favProducts[index], values: false);
                        },
                        child: Container(
                          height: 35,width: 35,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.teal
                          ),
                          child: Center(child: Icon(Icons.delete_forever_outlined,color: Colors.white)),
                        ),
                      ),

                    ),
                  ],
                ),
              ),
            );
          },

        );
      },),
    );
  }
}
