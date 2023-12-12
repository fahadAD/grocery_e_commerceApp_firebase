import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:grocery_project_firebase/Under_A_BottomNavigationPages/userProfile.dart';
import 'package:provider/provider.dart';
import '../AddProductAdmin/addproduct.dart';
import '../Provider/allProvider.dart';
import '../SplashPages/splash2.dart';
import 'addtoCartTotalOrder.dart';
import 'catagoryFormPage.dart';
import 'favourite_list.dart';
import 'home.dart';
class BottomNavigationBars extends StatefulWidget {
  const BottomNavigationBars({super.key});
  @override
  State<BottomNavigationBars> createState() => _BottomNavigationBarsState();
}

class _BottomNavigationBarsState extends State<BottomNavigationBars> {
  int pages_index=0;
  int pages_index2=0;

   final pagess=[
    const HomePage(),
     const CatagoryFormScreen(),
    const AddtoCartTotalOrder(),
     const WishList(),
    const Profile(),
     const AddProductADMIN(),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ProfileProvider>(context,listen: false).getProfile();
    Provider.of<ProductProvider>(context,listen: false).getProduct();
  }
  final GlobalKey<ScaffoldState> _key=GlobalKey<ScaffoldState>();
  void openDrawer(){
    _key.currentState?.openEndDrawer();
  }
  void onItemTapped(int index){
    if(index==4){
      openDrawer();
    }else{
      setState(() {
        pages_index=index;
        pages_index2=index;
      });
    }
    // setState(() {
    //   pages_index=index;
    // });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _key,
      endDrawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Card(
                child: ListTile(
                  onTap: () {
                   setState(() {
                     pages_index2=4;
                   });
                   _key.currentState?.closeEndDrawer();
                   },
                  leading: const Icon(Icons.person),
                  title: const Text("Profile"),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
              ),
              Visibility(
                visible: Provider.of<ProfileProvider>(context).profile.isAdmin??false,
                child: Card(
                  child: ListTile(
                    onTap: () {
                       setState(() {
                        pages_index2=5;
                      });
                      _key.currentState?.closeEndDrawer();
                      },
                    leading: const Icon(Icons.add_business),
                    title: const Text("Add Products"),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  onTap: () async {
      await FirebaseAuth.instance.signOut();
      EasyLoading.showSuccess("LOg Out Done");
      Navigator.push(context, MaterialPageRoute(builder: (context) => const SplashScreen1(),));
                  },
                  leading: const Icon(Icons.logout),
                  title: const Text("Logout"),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
              ),
            ],
          ),
        ),
      ),
      body: pagess[pages_index2],
      bottomNavigationBar: CurvedNavigationBar(

          color: Colors.teal,
          backgroundColor: Colors.white,
          buttonBackgroundColor: Colors.teal,
          animationDuration: const Duration(milliseconds: 100),
          animationCurve: Curves.easeIn,
          height: 60.0,
          index: pages_index,
          // onTap: (value) => onItemTapped(value),
          onTap: onItemTapped,
          items: const [
            Icon(Icons.home_filled,color: Colors.white),
            Icon(Icons.grid_view_outlined,color: Colors.white),
            Icon(Icons.shopping_cart,color: Colors.white,size: 40),
            Icon(Icons.favorite,color: Colors.white),
            Icon(Icons.list_alt,color: Colors.white),

          ]),
    );
  }
}
