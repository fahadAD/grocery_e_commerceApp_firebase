import 'package:flutter/material.dart';
import '../../Model/datamodel.dart';
import '../detailsScreen.dart';
class ExpulsiveFormScreen extends StatefulWidget {
  const ExpulsiveFormScreen({super.key});

  @override
  State<ExpulsiveFormScreen> createState() => _ExpulsiveFormScreenState();
}

class _ExpulsiveFormScreenState extends State<ExpulsiveFormScreen> {
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
          icon: Icon(Icons.qr_code_outlined,color: Colors.black),
          tooltip: 'QR Code',
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
SizedBox(height: 15,),
            ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: productlist1.length,
              itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 6),
                child:   GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsScreen(name: "${productlist1[index].productName}",details: "",img: "${productlist1[index].productImg}",price: "${productlist1[index].productPrice}"),));
                  },
                  child: Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),

                        border: Border.all(color: Colors.black)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(

                          children: [
                            SizedBox(width: 10,),
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 30,
                              backgroundImage: AssetImage("${productlist1[index].productImg}"),
                            ),
                            SizedBox(width: 15,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${productlist1[index].productName}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                                Text("Organic",style: TextStyle( color: Colors.blueGrey)),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text("\$${productlist1[index].productPrice}",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red,fontSize: 18)),

                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(Icons.favorite,color: Colors.red,size: 25,),
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
                ),
              );
            },

            )

          ],
        ),
      ),
    );
  }
}
