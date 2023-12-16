class UserModel {
 late String name;
 late String uId;
 late String image;
  UserModel(
    this.uId,
    this.image,
      this.name
  );
 UserModel.fromJson(Map<String, dynamic> json)
  {
    name = json['Name'];
    uId = json['Uid'];
    image = json['ImageUrl'];
  }
}