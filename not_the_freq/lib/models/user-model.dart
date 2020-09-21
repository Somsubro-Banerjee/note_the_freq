class UserModel {
  String name;
  String uid;

  UserModel({this.name, this.uid});

  UserModel.fromJson(Map<String, dynamic> parsedJSON)
      : name = parsedJSON['name'],
        uid = parsedJSON['uid'];
}