import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ulimagym/pages/home/home_page.dart';
import '../../models/entities/Usuario.dart';
import '../../models/responses/user_member.dart';
import '../../services/user_service.dart';
import '../recover/recover_page.dart';
import '../signin/signin_page.dart';

class LoginController extends GetxController {
  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();
  RxString message = 'primer mensaje'.obs;
  var messageColor = Colors.white.obs;
  UserService userService = UserService();

  void isLooged(BuildContext context) {
    final userString = GetStorage().read('user');
    print('isLooged');
    print(userString);
    if (userString != null) {
      Usuario userLogged = Usuario.empty();
      Map<String, dynamic> userJson = jsonDecode(userString);
      UserMember userMember = UserMember.fromJson(userJson);
      userLogged.id = userMember.userId;
      userLogged.miembroId = userMember.memberId;
      Future.microtask(() {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(usuarioLogged: userLogged),
          ),
        );
      });
    }
  }

  void login(BuildContext context) async {
    print('hola desde el controlador');
    print(userController.text);
    print(passController.text);
    String user = userController.text;
    String password = passController.text;
    Usuario userLogged = Usuario.empty();

    UserMember? userMember = await userService.validate(user, password);
    if (userMember == null) {
      message.value = 'Ocurrio un error en el servidor';
      messageColor.value = Colors.red;
    } else if (userMember.memberId == 0 && userMember.userId == 0) {
      message.value = 'Usuario incorrecto';
      messageColor.value = Colors.red;
    } else {
      print('usuario correcto');
      message.value = 'Usuario correcto';
      messageColor.value = Colors.green;
      print('usuario correcto');
      message.value = 'Usuario correcto';
      messageColor.value = Colors.green;
      print('1 ++++++++++++++++++++++++++++++++++');
      print(userMember);
      print('2 ++++++++++++++++++++++++++++++++++');
      //
      final userJsonString = jsonEncode(userMember.toJson());
      await GetStorage().write('user', userJsonString);

      Future.delayed(Duration(seconds: 1), () {
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => HomePage(
                    usuarioLogged: userLogged,
                  )),
        );
      });
    }
  }

  void goToSignIn(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignInPage()),
    );
  }

  void goToRecover(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RecoverPage()),
    );
  }
}
