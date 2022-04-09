import 'package:flutter/material.dart';

class APIReturn {
  APIReturn(
      {@required this.status,
      this.message,
      this.code,
      this.data,
      this.dataCount});
  bool status;
  String message;
  dynamic data;
  int dataCount;
  String code;
  APIReturn.fromMap(Map<String, dynamic> map) {
    this.status = true;
    this.message = map['message'];
    this.data = map['data'];
    this.dataCount = map['dataCount'];
    this.code = map['code'];
  }
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "status": status,
      "message": message,
      "data": data,
      "dataCount": dataCount,
      "code": code,
    };
    return map;
  }
}
