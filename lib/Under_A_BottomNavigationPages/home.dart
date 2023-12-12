import 'dart:async';
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:grocery_project_firebase/Model/cart_model.dart';
import 'package:grocery_project_firebase/Model/ptoductmodel.dart';
import 'package:provider/provider.dart';
import '../Provider/allProvider.dart';
import 'detailsScreen.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIndex = 0;
  Timer? timer;
  PageController pageController = PageController(initialPage: 0);
  @override
  void initState() {
    // TODO: implement initStat
    super.initState();
    timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (pageIndex <= 6) {
        pageIndex++;
      } else {
        pageIndex = 0;
      }
      pageController.animateToPage(pageIndex,
          duration: Duration(milliseconds: 350), curve: Curves.easeIn);
    });
  }

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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
    timer = null;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _demo = [
      Container(
        height: 170,
        width: MediaQuery.of(context).size.width / 1.2,
        color: Colors.white,
        child: Card(
          elevation: 20,
          child: Image.asset(
            "images/slider2.jpg",
            fit: BoxFit.fill,
            height: 165,
            width: MediaQuery.of(context).size.width / 1.2,
          ),
        ),
      ),
      Container(
        height: 170,
        width: MediaQuery.of(context).size.width / 1.2,
        color: Colors.white,
        child: Card(
          elevation: 20,
          child: Image.asset(
            "images/slider1.jpg",
            fit: BoxFit.fill,
            height: 165,
            width: MediaQuery.of(context).size.width / 1.2,
          ),
        ),
      ),
      Container(
        height: 170,
        width: MediaQuery.of(context).size.width / 1.2,
        color: Colors.white,
        child: Card(
          elevation: 20,
          child: Image.asset(
            "images/slider3.jpg",
            fit: BoxFit.fill,
            height: 165,
            width: MediaQuery.of(context).size.width / 1.2,
          ),
        ),
      ),
      Container(
        height: 170,
        width: MediaQuery.of(context).size.width / 1.2,
        color: Colors.white,
        child: Card(
          elevation: 20,
          child: Image.asset(
            "images/slider4.jpg",
            fit: BoxFit.fill,
            height: 165,
            width: MediaQuery.of(context).size.width / 1.2,
          ),
        ),
      ),
      Container(
        height: 170,
        width: MediaQuery.of(context).size.width / 1.2,
        color: Colors.white,
        child: Card(
          elevation: 20,
          child: Image.asset(
            "images/splash3.jpg",
            fit: BoxFit.cover,
            height: 165,
            width: MediaQuery.of(context).size.width / 1.2,
          ),
        ),
      ),
      Container(
        height: 170,
        width: MediaQuery.of(context).size.width / 1.2,
        color: Colors.white,
        child: Card(
          elevation: 20,
          child: Image.asset(
            "images/splash4.jpg",
            fit: BoxFit.cover,
            height: 165,
            width: MediaQuery.of(context).size.width / 1.2,
          ),
        ),
      ),
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              ListTile(
                title: Text("Home",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
                trailing: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    foregroundColor: Colors.white,
                    backgroundImage: NetworkImage(
                      "${FirebaseAuth.instance.currentUser?.photoURL}",
                    ),
                    radius: 25,
                  ),
                ),
              ),
              ListTile(
                title: Text("MD Fahad",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Colors.black)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 1.3,
                    child: Card(
                      elevation: 5,
                      color: Colors.white70,
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Search Fruits,vegitables ect..",
                          hintStyle: const TextStyle(color: Colors.blueGrey),
                          enabledBorder: InputBorder.none,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: const Icon(
                            Icons.search_outlined,
                            color: Colors.teal,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(10)),
                    child: Icon(Icons.filter_alt_outlined, color: Colors.white),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: Container(
                  height: 170,
                  child: Card(
                    elevation: 20,
                    child: PageView(
                      controller: pageController,
                      children: _demo,
                      onPageChanged: (index) {
                        setState(() {
                          pageIndex = index;
                        });
                      },
                    ),
                  ),
                ),
              ),
              CarouselIndicator(
                height: 4,
                color: Colors.black,
                activeColor: Colors.teal,
                count: _demo.length,
                index: pageIndex,
              ),
              SizedBox(
                height: 10,
              ),

              ListTile(
                title: Text("Exclusive Organic Products",
                    style: TextStyle(color: Colors.black, fontSize: 20)),
                trailing: Text("See all",
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold)),
              ),

              // horizontal
              SizedBox(
                width: MediaQuery.of(context).size.width,

                child: Consumer<ProductProvider>(
                  builder: (context, value, child) {
                    return GridView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: value.product.length,
                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.7,
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (BuildContext context, int index) {

                        bool fav = value.product[index].isFav;

                        return Container(
                          margin: EdgeInsets.all(8.0),
                          height: 210,
                          width: MediaQuery.of(context).size.width / 2.5,
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
              SizedBox(
                height: 8,
              ),

              ListTile(
                title: Text("Exclusive Offer",
                    style: TextStyle(color: Colors.black, fontSize: 20)),
                trailing: Text("See all",
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold)),
              ),
              //vertical
              SizedBox(
                height: 210,
                width: MediaQuery.of(context).size.width,

                child: Consumer<ProductProvider>(
                  builder: (context, value, child) {
                    return ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: value.product.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        bool fav = value.product[index].isFav;
                        return Container(
                          margin: EdgeInsets.all(8.0),
                          height: 210,
                          width: MediaQuery.of(context).size.width / 2.5,
                          decoration: BoxDecoration(
                              color: Colors.deepOrange.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.black)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                alignment: AlignmentDirectional.topEnd,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        // Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsScreen(name: "${productlist1[index].productName}",details: "",img: "${productlist1[index].productImg}",price: "${productlist1[index].productPrice}"),));
                                      },
                                      // child: Image.file(File("${product_data.productImagE}"),
                                      child: Image.network(
                                        value.product[index].productImagE,
                                        height: 105,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.5,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: GestureDetector(
                                      onTap: () async {
                                        await addFav(
                                            product: value.product[index],
                                            values: !fav);
                                      },
                                      child:fav? Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                      ):Icon(
                                        Icons.favorite,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5, left: 5),
                                child:
                                    Text("${value.product[index].productNamE}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 2, left: 5),
                                child: Text(
                                    "Organic",
                                    style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontSize: 12,
                                    )),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(top: 6, left: 2),
                                    child: Text(
                                      "Per kg: \$${value.product[index].salePricE}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.orange,
                                         ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Container(
                                      height: 35,
                                      width: 35,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.teal),
                                      child: Center(
                                          child: Icon(Icons.add,
                                              color: Colors.white)),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),






              SizedBox(
                height: 8,
              ),



              // SizedBox(
              //   height: 210,
              //   child: FutureBuilder<List<ProductModel>>(
              //       future: getProductRepo(),
              //       builder: (context, snapshot) {
              //     if(snapshot.hasData){
              //       return ListView.builder(
              //         scrollDirection: Axis.horizontal,
              //
              //         itemCount: snapshot.data?.length,
              //         itemBuilder: (BuildContext context, int index) {
              //           ProductModel product_data= snapshot.data?[index] as ProductModel ;
              //
              //           return  Container(
              //             margin: EdgeInsets.all(8.0),
              //             height: 210,
              //             width: MediaQuery.of(context).size.width/2.5,
              //             decoration: BoxDecoration(
              //                 color: Colors.black.withOpacity(0.1),
              //                 borderRadius: BorderRadius.circular(15),
              //                 border: Border.all(color: Colors.black)
              //             ),
              //             child:  Column(
              //               mainAxisAlignment: MainAxisAlignment.start,
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 Stack(
              //                   alignment:AlignmentDirectional.topEnd ,
              //                   children: [
              //                     ClipRRect(
              //                       borderRadius:BorderRadius.only(
              //                         topLeft: Radius.circular(15),
              //                         topRight: Radius.circular(15),
              //                       ),
              //                       child: GestureDetector(
              //                         onTap: () {
              //                           Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsScreen(name: "${productlist1[index].productName}",details: "",img: "${productlist1[index].productImg}",price: "${productlist1[index].productPrice}"),));
              //                         },
              //                         // child: Image.file(File("${product_data.productImagE}"),
              //                         child: Image.file(File("${product_data.productImagE}"),
              //                           height: 105,
              //                           width: MediaQuery.of(context).size.width/2.5,
              //                           fit: BoxFit.fill,
              //                         ),
              //                       ),
              //                     ),
              //                     Padding(
              //                       padding: const EdgeInsets.all(4.0),
              //                       child: Icon(Icons.favorite,color: Colors.red,),
              //                     )
              //                   ],
              //                 ),
              //                 Padding(
              //                   padding: const EdgeInsets.only(top: 5,left: 5),
              //                   child: Text("${product_data.productNamE}",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,)),
              //                 ),
              //
              //                 Padding(
              //                   padding: const EdgeInsets.only(top: 2,left: 5),
              //                   child: Text("Purse Price:${product_data.purchasePricE}",style: TextStyle(color: Colors.blueGrey,fontSize: 12,)),
              //                 ),
              //
              //                 Row(
              //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                   children: [
              //                     Padding(
              //                       padding: const EdgeInsets.only(top: 6,left: 5),
              //                       child: Text("\$${product_data.salePricE}",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.orange,fontSize: 18),),
              //                     ),
              //                     Padding(
              //                       padding: const EdgeInsets.only(right: 5),
              //                       child: Container(
              //                         height: 35,width: 35,
              //                         decoration: BoxDecoration(
              //                             shape: BoxShape.circle,
              //                             color: Colors.teal
              //                         ),
              //                         child: Center(child: Icon(Icons.add,color: Colors.white)),
              //                       ),
              //
              //                     ),
              //
              //                   ],
              //                 )
              //               ],
              //             ),
              //           );
              //         },
              //
              //       );
              //     }else{
              //       return Center(child: CircularProgressIndicator());
              //     }
              //       },),
              // ),

            ],
          ),
        ),
      ),
    );
  }
}
