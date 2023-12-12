import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:grocery_project_firebase/Model/ptoductmodel.dart';
import 'package:provider/provider.dart';

import '../Model/cart_model.dart';
import '../Provider/allProvider.dart';


 class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key, required this.all_products_data});

final ProductModel all_products_data;


  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}
class _DetailsScreenState extends State<DetailsScreen> {

  Future<void> addFav({required ProductModel product, required bool values}) async {
    DocumentReference f = FirebaseFirestore.instance
        .collection(FirebaseAuth.instance.currentUser?.uid ?? "")
        .doc("AllproductS")
        .collection("product")
        .doc(product.databaseKey);
    await f.update({
      "isFav": values,
    });

    Provider.of<ProductProvider>(context, listen: false).updateProducts();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,elevation: 0,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios,color: Colors.black,)),
        actions: [
          IconButton(
            icon: const Icon(Icons.share,color: Colors.black),
            tooltip: 'Share',
            onPressed: () {

            },
          ),
        ],
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width/1.3,
            decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(30)
            ),
            child: Center(child: Text("Add to cart",style: TextStyle(color: Colors.white,fontSize: 19))),
          ),
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                color: Colors.black26,
                shape: BoxShape.circle
            ),
            child: Center(child: Icon(Icons.favorite,color: Colors.red)),
          )

        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height:280,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(90),
                    bottomRight: Radius.circular(90),
                  )
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(90),
                  bottomRight: Radius.circular(90),
                ),
                child: Image.network("${widget.all_products_data.productImagE}",
                  height:280,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(height: 10,),
            ListTile(
              title: Text("${widget.all_products_data.productNamE}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25)),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text("Organic",style: TextStyle(color: Colors.blueGrey)),
              ),
            ),

            RichText(
              text: TextSpan(
                text: '',
                style: TextStyle(),
                children:   <TextSpan>[
                  TextSpan(text: "   Sale Price :", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.orange,fontSize: 18)),
                  TextSpan(text: '  \$${widget.all_products_data.salePricE}', style: TextStyle(color: Colors.black)),
                  TextSpan(text: ' / Per kilo', style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold)),


                ],
              ),
            ),
            SizedBox(height: 15,),
            RichText(
              text: TextSpan(
                text: '',
                style: TextStyle(),
                children:   <TextSpan>[
                  TextSpan(text: "   Purse Price :", style: TextStyle(fontWeight: FontWeight.normal,color: Colors.orange,fontSize: 18)),
                  TextSpan(text: '  \$${widget.all_products_data.purchasePricE}', style: TextStyle(color: Colors.black)),
                  TextSpan(text: ' / Per kilo', style: TextStyle(color: Colors.grey,fontWeight: FontWeight.normal)),


                ],
              ),
            ),
            SizedBox(height: 10,),
            RichText(
              text: TextSpan(
                text: '',
                style: TextStyle(),
                children:   <TextSpan>[
                  TextSpan(text: "   Product Stock :", style: TextStyle(fontWeight: FontWeight.normal,color: Colors.orange,fontSize: 18)),
                  TextSpan(text: '  ${widget.all_products_data.productStocK} KG', style: TextStyle(color: Colors.black)),


                ],
              ),
            ),
            SizedBox(height: 15,),
            RichText(
              text: TextSpan(
                text: '',
                style: TextStyle(),
                children:   <TextSpan>[
                  TextSpan(text: "   Product ID :", style: TextStyle(fontWeight: FontWeight.normal,color: Colors.orange,fontSize: 18)),
                  TextSpan(text: '  ${widget.all_products_data.productID}', style: TextStyle(color: Colors.black)),


                ],
              ),
            ),
            SizedBox(height: 15,),
            RichText(
              text: TextSpan(
                text: '',
                style: TextStyle(),
                children:   <TextSpan>[
                  TextSpan(text: "   Database Key :", style: TextStyle(fontWeight: FontWeight.normal,color: Colors.orange,fontSize: 18)),
                  TextSpan(text: '  ${widget.all_products_data.databaseKey}', style: TextStyle(color: Colors.black)),


                ],
              ),
            ),
            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width/3.0,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.black)
                    ),
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.add_business,color: Colors.green,size: 30,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("100%",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.teal),),
                            Text('Organic',style: TextStyle(color: Colors.blueGrey),)
                          ],
                        )
                      ],
                    )
                ),
                Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width/3.0,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.black)
                    ),
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.date_range,color: Colors.blue,size: 30,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("1 Year",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.teal),),
                            Text('Expriation',style: TextStyle(color: Colors.blueGrey),)
                          ],
                        )
                      ],
                    )
                )
              ],
            ),
            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width/3.0,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.black)
                    ),
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.star,color: Colors.orangeAccent,size: 30,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("4.5",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.teal),),
                            Text('Reviews',style: TextStyle(color: Colors.blueGrey),)
                          ],
                        )
                      ],
                    )
                ),
                Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width/3.0,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.black)
                    ),
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.opacity,color: Colors.orange,size: 30,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("80 kcal",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.teal),),
                            Text('100 Gram',style: TextStyle(color: Colors.blueGrey),)
                          ],
                        )
                      ],
                    )
                ),


              ],
            ),

            SizedBox(height: 6,),
            ListTile(
              title: Text("Related Products",style: TextStyle(color: Colors.black,fontSize: 20)),
              trailing: Text("See all",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold)),
            ),

            // SizedBox(
            //   height: 210,
            //   child: ListView.builder(
            //     scrollDirection: Axis.horizontal,
            //
            //     itemCount: productlist1.length,
            //     itemBuilder: (BuildContext context, int index) {
            //        return  Container(
            //          margin: EdgeInsets.all(8.0),
            //          height: 210,
            //          width: MediaQuery.of(context).size.width/2.5,
            //          decoration: BoxDecoration(
            //              color: Colors.black.withOpacity(0.1),
            //              borderRadius: BorderRadius.circular(15),
            //              border: Border.all(color: Colors.black)
            //          ),
            //          child:  Column(
            //            mainAxisAlignment: MainAxisAlignment.start,
            //            crossAxisAlignment: CrossAxisAlignment.start,
            //            children: [
            //              Stack(
            //                alignment:AlignmentDirectional.topEnd ,
            //                children: [
            //                  ClipRRect(
            //                    borderRadius:BorderRadius.only(
            //                      topLeft: Radius.circular(15),
            //                      topRight: Radius.circular(15),
            //                    ),
            //                    child: GestureDetector(
            //                      onTap: () {
            //                        // Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsScreen(name: "${productlist1[index].productName}",details: "",img: "${productlist1[index].productImg}",price: "${productlist1[index].productPrice}"),));
            //                      },
            //                      child: Image.asset("${productlist1[index].productImg}",
            //                        height: 105,
            //                        width: MediaQuery.of(context).size.width/2.5,
            //                        fit: BoxFit.fill,
            //                      ),
            //                    ),
            //                  ),
            //                  Padding(
            //                    padding: const EdgeInsets.all(4.0),
            //                    child: Icon(Icons.favorite,color: Colors.red,),
            //                  )
            //                ],
            //              ),
            //              Padding(
            //                padding: const EdgeInsets.only(top: 5,left: 5),
            //                child: Text("${productlist1[index].productName}",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 17)),
            //              ),
            //
            //              Padding(
            //                padding: const EdgeInsets.only(top: 2,left: 5),
            //                child: Text("Organic",style: TextStyle(color: Colors.blueGrey,fontSize: 12,)),
            //              ),
            //
            //              Row(
            //                mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                children: [
            //                  Padding(
            //                    padding: const EdgeInsets.only(top: 6,left: 5),
            //                    child: Text("\$${productlist1[index].productPrice}",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.orange,fontSize: 18),),
            //                  ),
            //                  Padding(
            //                    padding: const EdgeInsets.only(right: 5),
            //                    child: Container(
            //                      height: 35,width: 35,
            //                      decoration: BoxDecoration(
            //                          shape: BoxShape.circle,
            //                          color: Colors.teal
            //                      ),
            //                      child: Center(child: Icon(Icons.add,color: Colors.white)),
            //                    ),
            //
            //                  ),
            //
            //                ],
            //              )
            //            ],
            //          ),
            //        );
            //     },
            //
            //   ),
            // ),

            SizedBox(
              // width: MediaQuery.of(context).size.width,
              height: 260,
              child: Consumer<ProductProvider>(
                builder: (context, value, child) {
                  return ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: value.product.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {

                      bool fav = value.product[index].isFav;

                      return Container(
                        margin: EdgeInsets.all(5.0),
                        height: 260,
                        width: MediaQuery.of(context).size.width / 2.2,
                        decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.black)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>   DetailsScreen(all_products_data: value.product[index],)));
                                },
                                child: Image.network(
                                  value.product[index].productImagE,
                                  height: 115,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(top: 5, left: 5),
                              child:
                              Text("${value.product[index].productNamE}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 16
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 2, left: 5),
                              child: Text(
                                  "Organic",
                                  style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontSize: 11,
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 2, left: 5),
                              child: Text(
                                  "Stock :${value.product[index].productStocK} kilo more",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 11,
                                  )),
                            ),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.only(top: 4,left: 5 ),
                                  child: Text(
                                    "Per Kilo : ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.only(top: 2,),
                                  child: Text(
                                    "\$${value.product[index].salePricE}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orange,
                                        fontSize: 18),
                                  ),
                                ),

                              ],
                            ),

                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [

                                  GestureDetector(
                                    onTap:() {

                                      CartModel cart_model=CartModel(productID: value.product[index].productID, productImagE: value.product[index].productImagE, productNamE: value.product[index].productNamE, productStocK: value.product[index].productStocK, purchasePricE: value.product[index].purchasePricE, salePricE: value.product[index].salePricE, isFav: value.product[index].isFav, quantity: 1);
                                      Provider.of<CartProvider>(context,listen: false).addtoCart(cart_Model: cart_model);
                                      EasyLoading.showToast("Cart Added");
                                    }, child: Padding(

                                    padding: const EdgeInsets.only(right: 5),
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(

                                          shape: BoxShape.circle,
                                          color: Colors.teal),
                                      child: Center(
                                          child: Icon(Icons.shopping_cart,
                                              color: Colors.white)),
                                    ),
                                  ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Colors.grey),
                                          shape: BoxShape.circle,
                                          color: Colors.white),
                                      child:  Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: GestureDetector(
                                            onTap: () async {
                                              await addFav(
                                                  product: value.product[index],
                                                  values: !fav);
                                            },
                                            child: fav
                                                ? Icon(
                                              Icons.favorite,
                                              color: Colors.red,
                                            )
                                                : Icon(
                                              Icons.favorite,
                                              color: Colors.grey,
                                            )),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 6,),
          ],
        ),
      ),
    );
  }
}
