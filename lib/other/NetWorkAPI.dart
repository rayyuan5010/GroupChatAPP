import 'package:dio/dio.dart';
import 'package:group_chat/core/logger.dart';
import 'package:group_chat/other/auth.dart';

import 'apireturn.dart';
import 'config.dart';

class NetWorkAPI {
  static Future<APIReturn> _sendHTTP(
      Map<String, dynamic> data, String url) async {
    Response response;
    var dio = Dio();
    if (Authentication.user != null) {
      data.addAll({"AuthID": Authentication.user.id});
    } else {
      data.addAll({"AuthID": null});
    }

    var formData = FormData.fromMap(data);
    response =
        await dio.post('http://${Config.serverIP}/api$url', data: formData);
    getLogger("NetWorkAPI").d(response.statusCode);
    if (response.statusCode == 200) {
      print(response.data);
      return APIReturn.fromMap(response.data);
    } else {
      return APIReturn(status: false, message: 'server error');
    }
  }

  static Future<APIReturn> createUser(String email, String password) async {
    return _sendHTTP({'email': email, 'password': password}, "/user/insert");
  }

  static Future<APIReturn> userLogin(String email, String password) async {
    return _sendHTTP({'email': email, 'password': password}, "/user/get");
  }

  static Future<APIReturn> getGroup() async {
    return _sendHTTP({'userId': Authentication.user.id}, "/mixData/get");
  }

  static Future<APIReturn> updateToken(String token) async {
    return _sendHTTP({'token': token}, "/user/token/update");
  }

  static Future<APIReturn> sendMessage(String receiverId, String message,
      {bool group = false}) {
    return _sendHTTP({
      "receiverId": receiverId,
      "message": message,
      "senderId": Authentication.user.id
    }, "/message/insert");
  }
}
