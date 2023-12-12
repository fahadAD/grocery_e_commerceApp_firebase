import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grocery_project_firebase/Model/profile-model.dart';
import 'package:grocery_project_firebase/Model/ptoductmodel.dart';

Future<ProfileModel> getProfileRepo()async{
  DocumentReference users_Profile=FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser?.uid??"").doc("profileS");
  final DocumentSnapshot data=await users_Profile.get();
  ProfileModel model=ProfileModel.fromJson(json: data.data()as Map<String,dynamic>);
 return model;
}

Future<List<ProductModel>> getProductRepo()async{
  List<ProductModel> _listofAll_products=[];

  CollectionReference usersproduct_Data=FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser?.uid??"").doc("AllproductS").collection("product");
final QuerySnapshot data=await usersproduct_Data.get();

  for (var element in data.docs) {
    // Map<String, dynamic> _products =element.data() as Map<String, dynamic>;
    // _listofAll_products.add(ProductModel.fromJson(json: _products));
    //same
    ProductModel data2=ProductModel.fromJson(json: element.data() as Map<String, dynamic>);
    data2.databaseKey=element.id;
    _listofAll_products.add(data2);
  }
return _listofAll_products;
 }

// Future<List<ProductModel>> getFavouriteRepo()async{
//   List<ProductModel> fav_List=[];
//
//   CollectionReference usersproduct_Data=FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser?.uid??"").doc("AllproductS").collection("product");
//   final QuerySnapshot data=await usersproduct_Data.get();
//
//   for (var element in data.docs) {
//     // Map<String, dynamic> _products =element.data() as Map<String, dynamic>;
//     // _listofAll_products.add(ProductModel.fromJson(json: _products));
//     //same
//
//     ProductModel data2=ProductModel.fromJson(json: element.data() as Map<String, dynamic>);
//     if(data2.isFav){
//       data2.databaseKey=element.id;
//       fav_List.add(data2);
//     }
//   }
//   return fav_List;
// }
