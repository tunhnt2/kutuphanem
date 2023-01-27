class UserModel {
  String? id, email, userName, image;
  UserModel({this.id, this.userName, this.email, this.image});
  static UserModel? current;
  factory UserModel.fromJson(Map<String, dynamic> j) => 
      UserModel(email: j['email'], id: j['id'], userName: j['userName'], image: j['image']);
  Map<String, dynamic> toMap() => {
    "id": id,
    "email": email,
    "userName": userName,
    "image": image
  };
}