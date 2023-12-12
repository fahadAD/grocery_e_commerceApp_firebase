class CartModel {
  late int productID, productStocK,quantity;
  late String productNamE, productImagE;
  late double salePricE, purchasePricE;
  String? databaseKey;
  late bool isFav;


  CartModel(
      {this.databaseKey,
      required this.productID,
      required this.productImagE,
      required this.productNamE,
      required this.productStocK,
      required this.purchasePricE,
      required this.salePricE,
      required this.isFav,required this.quantity});


}
