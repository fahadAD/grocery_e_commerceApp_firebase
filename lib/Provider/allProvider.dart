import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:grocery_project_firebase/Model/cart_model.dart';
import 'package:grocery_project_firebase/Model/ptoductmodel.dart';
import '../Model/profile-model.dart';
import '../Model/allRepo.dart';

class ProfileProvider extends ChangeNotifier {
  ProfileModel profile = ProfileModel();
  bool isloding = false;

  Future<void> getProfile() async {
    isloding = true;
    profile = await getProfileRepo();
    isloding = false;
    notifyListeners();
  }
  // Future<void> updateProfile()async{
  //   isloding=true;
  //   user=await getProfileRepo();
  //   isloding=false;
  // }
}


class ProductProvider extends ChangeNotifier {
  List<ProductModel>  product =[];
  List<ProductModel>  favProducts =[];
  bool isloding = false;

  Future<void> getProduct() async {
    isloding = true;
     product=await getProductRepo();
    isloding = false;
    notifyListeners();
  }

  Future<void> updateProducts() async {
    product = await getProductRepo();
    getFavouriteProducts();
    notifyListeners();
  }

   getFavouriteProducts()async{
    favProducts.clear();
    for (var element in product) {
      if(element.isFav){
         favProducts.add(element);
      }
    }
    // notifyListeners();
   }

}


class CartProvider extends ChangeNotifier{
  List<CartModel>  cartList =[];
 double subtotal=0;

 calculateSubtotal()async{
     subtotal=0;
   for (var element in cartList) {
     subtotal += (element.quantity*element.salePricE);

   }
    notifyListeners();
 }


  addtoCart({required CartModel cart_Model})async{
    if(cartList.isNotEmpty){
      for (var element in cartList) {

        if(element.productID==cart_Model.productID){
          element.quantity++;
          break;
        }
        if(element==cartList.last){
          cartList.add(cart_Model);
        }
      }
    }else{
      cartList.add(cart_Model);
    }
    calculateSubtotal();
   notifyListeners();
}

deletefromCart({required CartModel cart_Model})async{
 cartList.remove(cart_Model);
 calculateSubtotal();
 notifyListeners();
}

addQuentity({required int add_index})async{
  if(cartList[add_index].quantity<cartList[add_index].productStocK){
    cartList[add_index].quantity++;
  }else{
    EasyLoading.showError("Out of stock");
  }
  calculateSubtotal();
  notifyListeners();
}
minusQuentity({required int min_index})async{
    if(cartList[min_index].quantity<=0){
     cartList.remove(cartList[min_index]);
    }else{
      cartList[min_index].quantity--;
    }
    calculateSubtotal();
    notifyListeners();
  }

 cartClear(){
   cartList.clear();
   calculateSubtotal();
   notifyListeners();
}

}
