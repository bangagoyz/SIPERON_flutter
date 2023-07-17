import 'package:flutter/material.dart';
import 'package:perpus/Screens/Admin/AdminBukuScreen.dart';
import 'package:perpus/Screens/Admin/AdminBukuTamuScreen.dart';
import 'package:perpus/Screens/Admin/Crud/EditBukuScreen.dart';
import 'package:perpus/Screens/Admin/Crud/QRBukuScreen.dart';
import 'package:perpus/Screens/Admin/peminjaman/AdminPeminjamanScreen.dart';
import 'package:perpus/Screens/Login/LoginScreens.dart';
import 'package:perpus/Screens/Register/RegisterScreen.dart';
import 'package:perpus/Screens/User/Buku/DataBukuScreen.dart';
import 'package:perpus/Screens/User/Buku/bukuScanner.dart';
import 'package:perpus/Screens/User/Kunjungan/KunjunganScanner.dart';
import 'package:perpus/Screens/User/Kunjungan/UserKunjunganScreen.dart';
import 'package:perpus/Screens/User/Peminjaman/DataPeminjamanScreens.dart';
import 'package:perpus/Screens/User/Peminjaman/PeminjamanScreens.dart';
import 'package:perpus/Screens/User/UserHomeScreen.dart';

import 'Screens/Admin/AdminHomeScreen.dart';
import 'Screens/Admin/Crud/InputBukuScreen.dart';

final Map<String, WidgetBuilder> routes = {
  //Front interface
  LoginScreen.routeName: (context) => LoginScreen(),
  RegisterScreen.routeName: (context) => RegisterScreen(),

  //User
  UserHomeScreen.routeName: (context) => UserHomeScreen(),
  DataBukuScreens.routeName: (context) => DataBukuScreens(),
  PeminjamanScreens.routeName: (context) => PeminjamanScreens(),
  DataPeminjamanScreens.routeName: (context) => DataPeminjamanScreens(),
  KunjunganScanner.routeName: (context) => KunjunganScanner(),
  UserKunjunganScreens.routeName: (context) => UserKunjunganScreens(),

  //admin
  AdminHomeScreen.routeName: (context) => AdminHomeScreen(),
  InputBukuScreens.routeName: (context) => InputBukuScreens(),
  EditBukuScreens.routeName: (context) => EditBukuScreens(),
  AdminBukuScreen.routeName: (context) => AdminBukuScreen(),
  AdminPeminjamanScreens.routeName: (context) => AdminPeminjamanScreens(),
  QRBukuScreens.routeName: (context) => QRBukuScreens(),
  AdminBukuTamuScreen.routeName: (context) => AdminBukuTamuScreen(),

  //scanner
  bukuScanner.routeName: (context) => bukuScanner()
};
