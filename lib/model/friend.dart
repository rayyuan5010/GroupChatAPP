import 'package:flutter/material.dart';

class Friend {
  Friend(
      {@required this.id, @required this.name, this.image, this.userSM = ""});
  String id;
  String name;
  String image;
  String userSM;
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "id": id,
      "name": name,
      "image": image,
      "userSM": userSM,
    };
    return map;
  }

  Friend.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.name = map['name'];
    this.userSM = map['userSM'] ?? "";
    this.image = map['image'] ?? "";
  }
}
