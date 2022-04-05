import 'package:flutter/material.dart';

class User {
  User(
      {@required this.id,
      @required this.account,
      @required this.password,
      this.name,
      this.image,
      this.userSM,
      this.firendCode});
  String id;
  String account;
  String password;
  String name;
  String image;
  String userSM;
  String firendCode;
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "id": id,
      "account": account,
      "password": password,
      "userSM": userSM,
      "name": name,
      "image": image,
      "firendCode": firendCode,
    };
    return map;
  }

  User.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.account = map['account'];
    this.password = map['password'];
    this.userSM = map['userSM'];
    this.name = map['name'];
    this.image = map['image'];
    this.firendCode = map['firendCode'];
  }
}
