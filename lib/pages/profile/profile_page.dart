import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'profile_controller.dart';

class ProfilePage extends StatelessWidget {
  ProfileController control = Get.put(ProfileController());

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Text('Profile Page'),
    );
  }

  Widget _takePicture(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.camera_alt_outlined,
        color: Colors.white,
      ),
      onPressed: () {
        print('tomar foto');
      },
    );
  }

  Widget _popUpMenu(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(
        Icons.more_vert, // Icono de tres puntos
        color: Colors.white, // Cambia el color del icono aquí
      ),
      onSelected: (String value) {
        switch (value) {
          case 'profile':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
            );
            break;
          case 'help':
            print('estamos en help');
            break;
          case 'signOut':
            print('estamos en signOut');
            exit(0);
            break;
          default:
            print('Naranjas');
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(value: 'profile', child: Text('Mi perfil')),
        PopupMenuItem<String>(value: 'help', child: Text('Ayuda')),
        PopupMenuItem<String>(value: 'signOut', child: Text('Cerrar Sesión')),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    control.fetchUserData();
    return MaterialApp(
        home: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          title: Text(
            'ULima Gym',
            style: TextStyle(color: Colors.white),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Color(0XFFF26F29),
          actions: [_takePicture(context), _popUpMenu(context)]),
      body: _buildBody(context),
    ));
  }
}
