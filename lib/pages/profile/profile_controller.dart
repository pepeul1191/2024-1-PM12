import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../models/responses/user_member.dart';

class ProfileController extends GetxController {
  void fetchUserData() async {
    final userString = GetStorage().read('user');
    print('fetchUserData-------------------------');
    print(userString);
    if (userString != null) {
      Map<String, dynamic> userMap = jsonDecode(userString);
      print(userMap);
      print('ññññññññññññññññññññ');
      UserMember user = UserMember.fromJson(jsonDecode(userString));
      print('User logged userId: ${user.userId}, memberId: ${user.memberId}');
    } else {
      print('No user logged');
    }
  }
}
