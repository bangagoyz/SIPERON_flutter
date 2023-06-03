import 'package:flutter/material.dart';
import 'package:perpus/Screens/Login/LoginScreens.dart';
import 'package:perpus/Screens/Register/RegisterScreen.dart';

final Map<String, WidgetBuilder> routes = {
  LoginScreen.routeName: (context) => LoginScreen(),
  RegisterScreen.routeName: (context) => RegisterScreen()
};
