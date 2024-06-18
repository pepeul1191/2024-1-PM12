import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/user_service.dart';

class RecoverController extends GetxController {
  TextEditingController dniController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  UserService userService = UserService();
  RxString message = 'primer mensaje'.obs;
  var messageColor = Colors.white.obs;

  void resetPassword() async {
    String dni = dniController.text;
    String email = emailController.text;
    String? messageServer = await userService.reset(dni, email);
    if (messageServer == null) {
      message.value = 'Ocurrió un error con el servidor';
      messageColor.value = Colors.red;
    } else {
      print('1   +++++++++++++++++++++++++++++++');
      print(messageServer);
      print("Contraseña actualizada");
      print('2 +++++++++++++++++++++++++++++++');
      if (messageServer == "Contraseña actualizada") {
        print("IFFFFFFFFFFFFFFFFFFFFFFFFFFFF");
        message.value =
            'Se le ha enviado un correo para que cambie su contraseña';
        messageColor.value = Colors.green;
      } else {
        print("ELSEEEEEEEEEEEEEE");
        message.value = 'Datos inválidos';
        messageColor.value = Colors.red;
      }
    }
  }
}
