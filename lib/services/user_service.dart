import 'dart:convert';

import 'package:ulimagym/configs/constants.dart';
import 'package:http/http.dart' as http;
import '../models/responses/user_member.dart';

class UserService {
  Future<UserMember?> validate(String user, String password) async {
    String url = "${BASE_URL}user/validate";
    print(url);
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields['user'] = user;
    request.fields['password'] = password;
    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        final UserMember em = UserMember.fromJson(json.decode(responseBody));
        return em;
      } else if (response.statusCode == 404) {
        final UserMember em = UserMember(userId: 0, memberId: 0);
        return em;
      } else {
        print('ERROORRR!!!');
      }
    } catch (e, stackTrace) {
      print('Error no esperado: $e');
      print(stackTrace);
    }
  }

  Future<String?> reset(String dni, String email) async {
    String url = "${BASE_URL}user/reset";
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields['dni'] = dni;
    request.fields['email'] = email;
    try {
      var response = await request.send();
      print(response.statusCode);
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        final String r = responseBody;
        return r;
      } else if (response.statusCode == 404) {
        var responseBody = await response.stream.bytesToString();
        final String r = responseBody;
        return r;
      } else {
        print('ERROORRR!!!');
      }
    } catch (e, stackTrace) {
      print('Error no esperado: $e');
      print(stackTrace);
    }
  }
}
