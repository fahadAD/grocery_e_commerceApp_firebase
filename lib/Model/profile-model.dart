class ProfileModel{
  String? name;
   String? number;
  String? dateofbith;
  String? gender;
  String? age;
  String? landmark;
  String? id;
  bool? isAdmin;

  ProfileModel({this.name,this.number,this.age,this.dateofbith,this.gender,this.landmark,this.id,this.isAdmin});

  ProfileModel.fromJson({required Map<String, dynamic>json}){
 name=json["name"];
number=json["number"];
dateofbith=json["dateofbith"];
gender=json["gender"];
age=json["age"];
landmark=json["landmark"];
isAdmin=json["isAdmin"];
  }

  Map<String, dynamic> toJson()=> <String, dynamic>{
    "name" : name,
    "number" : number,
    "dateofbith" : dateofbith,
    "gender" : gender,
    "age" : age,
    "landmark" : landmark,
    "isAdmin" : isAdmin,
  };

}