class UserModel{
  late String? name;
  late String? email;
  late String? phone;
  late String? uId;

  UserModel({
     this.name,
     this.email,
     this.phone,
     this.uId,
});
  UserModel.fromJson(Map<String,dynamic>json)
  {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];
  }
  Map<String,dynamic> toMap()
  {
    return{
      'name':name,
      'email':email,
      'phone':phone,
      'uId':uId,
    };
  }
  // factory UserModel.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> document){
  //   final data = document.data()!;
  //   return UserModel(name: data['name'], email: data['email'], phone: data['phone'], uId: document.id);
  // }
}