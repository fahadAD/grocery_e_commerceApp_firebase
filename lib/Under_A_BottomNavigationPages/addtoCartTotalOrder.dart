import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:grocery_project_firebase/Provider/allProvider.dart';
import 'package:provider/provider.dart';

import 'detailsScreen.dart';
class AddtoCartTotalOrder extends StatefulWidget {
  const AddtoCartTotalOrder({super.key});

  @override
  State<AddtoCartTotalOrder> createState() => _AddtoCartTotalOrderState();
}

class _AddtoCartTotalOrderState extends State<AddtoCartTotalOrder> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.add),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text("Cartlist",style: TextStyle(color: Colors.black)),
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: Consumer<CartProvider>(builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0,),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.all(

                    Radius.circular(25)
                )
            ),
            height: 60,
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width*0.6,
                  decoration: BoxDecoration(
                    color: Colors.white,

                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(child: Text("Order Total",style: TextStyle(color: Colors.black),)),
                      Center(child: Text("\$ ${value.subtotal}",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight:  FontWeight.bold),)),

                    ],
                  ),
                ),
                Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width*0.4,
                  child: GestureDetector(
                    onTap: () {
                      value.cartClear();

                      EasyLoading.showSuccess("Order Success");
                    },
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Chek Out ",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 18),),
                        Icon(Icons.arrow_forward,color: Colors.white,size: 28,)

                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },),
      body: Consumer<CartProvider>(builder: (context, value, child) {
        return value.cartList.isEmpty?Center(child: Text("Cart is empty"))
            :
        SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("   Your Order",style: TextStyle(color: Colors.black,fontSize: 23,fontWeight: FontWeight.bold)),
                SizedBox(height: 10,),
                ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: value.cartList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Container(
                          height: 80,
                          width: MediaQuery.of(context).size.width/1.1,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.blue.withOpacity(0.1),
                              border: Border.all(color: Colors.black)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [

                               CircleAvatar(

                                 backgroundColor: Colors.white,
                                 radius: 25,
                                 backgroundImage: NetworkImage("${value.cartList[index].productImagE}"),
                               ),

                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${value.cartList[index].productNamE}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                                  Row(

                                    children: [
                                      GestureDetector(
                                  onTap:() {
                                    value.minusQuentity(min_index: index);
                                  },
                                        child: Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(

                                              shape: BoxShape.circle,
                                              color: Colors.teal),
                                          child: Center(
                                              child: Icon(Icons.remove,
                                                  color: Colors.white)),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 20,
                                          width: 20,
                                          decoration: BoxDecoration(

                                              shape: BoxShape.circle,
                                              color: Colors.black),
                                          child: Center(child: Text("${value.cartList[index].quantity}",style: TextStyle( color: Colors.white,fontWeight: FontWeight.bold))),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          value.addQuentity(add_index: index);
                                        },
                                        child: Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(

                                              shape: BoxShape.circle,
                                              color: Colors.teal),
                                          child: Center(
                                              child: Icon(Icons.add,
                                                  color: Colors.white)),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("\$${value.cartList[index].salePricE*value.cartList[index].quantity}",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red)),
                                  GestureDetector(
                                    onTap: () {
                                      value.deletefromCart(cart_Model: value.cartList[index]);
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(

                                          shape: BoxShape.circle,
                                          color: Colors.blue),
                                      child: Center(
                                          child: Icon(Icons.delete,
                                              color: Colors.white)),
                                    ),
                                  ),

                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [

                                  Text("${value.cartList[index].quantity}",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 18),),
                                  Text("KG",style: TextStyle(color: Colors.teal),),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    ;
                  },

                ),
                SizedBox(height: 10,),
                Text("   Your Coupone Code",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold)),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width/1.3,
                      child: Card(
                        elevation: 5,
                        color: Colors.white70,
                        child: TextFormField(
                          decoration:   InputDecoration(
                            hintText: "Type Cupon Code",
                            hintStyle: const TextStyle(color: Colors.blueGrey),
                            enabledBorder: InputBorder.none,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),),
                            prefixIcon: const Icon(Icons.label,color: Colors.teal,),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 40,width: 40,
                      decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Icon(Icons.add_circle_outlined,color: Colors.white),
                    )
                  ],
                ),
                ListTile(
                  title: Text("Subtotal",style: TextStyle(color: Colors.blueGrey)),
                  trailing: Text("${value.subtotal}",style: TextStyle(color: Colors.blueGrey)),
                ),
                ListTile(
                  title: Text("Discont",style: TextStyle(color: Colors.blueGrey)),
                  trailing: Text("-12%",style: TextStyle(color: Colors.blueGrey)),
                ),
                ListTile(
                  title: Text("Taxes",style: TextStyle(color: Colors.blueGrey)),
                  trailing: Text("40.00",style: TextStyle(color: Colors.blueGrey)),
                ),
                ListTile(
                  title: Text("Order Total",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17)),
                  trailing: Text("${value.subtotal}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17)),
                )
              ],
            ),
          ),
        );
      },),


    );
  }
}
