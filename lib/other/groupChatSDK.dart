import 'dart:convert';

import 'package:dio/dio.dart';

import 'apireturn.dart';
import 'config.dart';

class NetWorkAPI {
  static Future<APIReturn> createUser(String email, String password) async {
    Response response;
    var dio = Dio();
    var formData = FormData.fromMap({'email': email, 'password': password});
    response = await dio.post('http://${Config.serverIP}/api/user/insert',
        data: formData);
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.data);
      return APIReturn.fromMap(response.data);
    } else {
      return APIReturn(status: false, message: 'server error');
    }
  }

  static Future<APIReturn> userLogin(String email, String password) async {
    Response response;
    var dio = Dio();
    var formData = FormData.fromMap({'email': email, 'password': password});
    response = await dio.post('http://${Config.serverIP}/api/user/get',
        data: formData);
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.data);
      return APIReturn.fromMap(response.data);
    } else {
      return APIReturn(status: false, message: 'server error');
    }
  }
}
