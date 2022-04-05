import 'package:flutter/material.dart';

//{
//createdAt: 2022-03-02 03:48:12,
//deletedAt: null,
//id: 4Dtmfhh7j29wDiKTz4RXRAC5pYGA,
//image: null,
//name: 新群組,
//owner: 5UZcmL5LtuWQkVe7JiqZ,
//updatedAt: null
//}
class Group {
  Group(
      {@required this.id,
      @required this.name,
      @required this.owner,
      this.image});
  String id;
  String name;
  String owner;
  String image;
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "id": id,
      "name": name,
      "image": image,
      "owner": owner,
    };
    return map;
  }

  Group.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.name = map['name'];
    this.owner = map['owner'];
    this.image = map['image'] ?? "";
  }
}
