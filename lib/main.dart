import 'package:ezahora/constants/colors.dart';
import 'package:ezahora/views/ez_splash_view.dart';
import 'package:ezahora/views/menu_principal_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  //  En esta parte vamos a colocar el color de la barra de estado
  //  y el color de la barra de navegacion
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      systemNavigationBarColor: Colors.white,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EZAhora',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Palette.ezBlue,
      ),
      // home: const MenuPrincipal()
      home: const EzSplashView(),
    );
  }
}