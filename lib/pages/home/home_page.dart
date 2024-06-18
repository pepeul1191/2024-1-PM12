import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ulimagym/models/entities/Usuario.dart';
import 'package:ulimagym/pages/exercise/exercise_page.dart';
import 'package:ulimagym/pages/profile/profile_page.dart';
import 'package:ulimagym/pages/routine/routine_page.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final Usuario usuarioLogged;

  // Constructor que acepta un parámetro
  const HomePage({Key? key, required this.usuarioLogged}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState(user: usuarioLogged);
}

class _HomePageState extends State<HomePage> {
  HomeController control = Get.put(HomeController());
  int _selectedIndex = 0;
  Usuario user;
  late final List<Widget> _widgetOptions;

  _HomePageState({required this.user}) {
    _widgetOptions = [
      RoutinePage(user),
      ExercisePage(),
      ProfilePage(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _navigationBottom() {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.list_outlined),
          label: 'Mi Rutina',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.addchart_outlined),
          label: 'Ejercicios',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Mi Cuenta',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Color(0XFFF26F29),
      onTap: _onItemTapped,
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Text('Home Page'),
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
    print('usuario en home');
    print(this.user);
    return WillPopScope(
        onWillPop: () async {
          // Aquí puedes capturar el evento de swipe back
          print('Swipe back detected from HomePage!');
          // Implementa aquí las acciones que deseas realizar al detectar el swipe back
          exit(0);
          // Devuelve true para indicar que manejas el evento tú mismo
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
              title: Text(
                'ULima Gym',
                style: TextStyle(color: Colors.white),
              ),
              automaticallyImplyLeading: false,
              backgroundColor: Color(0XFFF26F29),
              actions: [_takePicture(context), _popUpMenu(context)]),
          body: _widgetOptions.elementAt(_selectedIndex),
          bottomNavigationBar: _navigationBottom(),
        ));
  }
}
