import 'package:flutter/material.dart';
import 'package:perpus/Screens/Login/LoginScreens.dart';
import 'package:perpus/routes.dart';
import 'package:perpus/theme.dart';

void main() async {
  runApp(MaterialApp(
    title: "Sistem Perpustakaan Online",
    theme: theme(),
    initialRoute: LoginScreen.routeName,
    routes: routes,
  ));
}
