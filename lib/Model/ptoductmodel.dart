class ProductModel{
 late int productID, productStocK;
 late String productNamE,productImagE;
 late double salePricE,purchasePricE;
   String? databaseKey;
   late bool isFav;


ProductModel({this.databaseKey,required this.productID,required this.productImagE,required this.productNamE,required this.productStocK,required this.purchasePricE,required this.salePricE,required this.isFav});

ProductModel.fromJson({required Map<String, dynamic>json}){
    productID=json["productID"];
    productStocK=json["productStocK"];
    productNamE=json["productNamE"];
    productImagE=json["productImagE"];
    salePricE=json["salePricE"];
    purchasePricE=json["purchasePricE"];
    isFav=json["isFav"];
   }

  Map<String, dynamic> toJson()=> <String, dynamic>{
    "productID" : productID,
    "productStocK" : productStocK,
    "productNamE" : productNamE,
    "productImagE" : productImagE,
    "salePricE" : salePricE,
    "purchasePricE" : purchasePricE,
    "isFav" : isFav,
   };

}