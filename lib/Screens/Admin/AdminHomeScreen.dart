import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:perpus/Components/Admin/AdminBukuTamuComponents.dart';
import 'package:perpus/Components/Admin/AdminHomeComponents.dart';
import 'package:perpus/Components/Admin/HomeAdminComponents.dart';
import 'package:perpus/Components/Admin/peminjaman/AdminPeminjamanComponents.dart';
import 'package:perpus/Screens/Login/LoginScreens.dart';
import 'package:perpus/Utils/constants.dart';
import 'package:perpus/size_config.dart';
import 'package:perpus/Components/Register/RegisterComponent.dart';

import '../../Components/Admin/AdminBukuComponent.dart';
import 'Crud/InputBukuScreen.dart';

class AdminHomeScreen extends StatefulWidget {
  static String routeName = "/home_admin";

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  DateTime timeBackPressed = DateTime.now();
  int index = 0;
  final screens = [
    AdminPeminjamanComponents(),
    AdminBukuComponents(),
    HomeAdminComponent(),
    AdminBukuTamuComponents()
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return WillPopScope(
        onWillPop: () async {
          final difference = DateTime.now().difference(timeBackPressed);
          final isExitWarning = difference >= Duration(seconds: 2);

          timeBackPressed = DateTime.now();

          if (isExitWarning) {
            final message = 'Tekan lagi untuk keluar';
            Fluttertoast.showToast(msg: message, fontSize: 18);
            SystemNavigator.pop();
            return false;
          } else {
            Fluttertoast.cancel();
            return true;
          }
        },
        child: Scaffold(
            body: screens[index],
            // body: AdminHomeComponent(),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                AwesomeDialog(
                    context: context,
                    dialogType: DialogType.INFO,
                    animType: AnimType.SCALE,
                    title: 'Keluar?',
                    desc: 'Yakin ingin keluar dari aplikasi? ....',
                    btnCancelOnPress: () {},
                    btnCancelText: "Tidak",
                    btnOkText: "Yakin",
                    btnOkOnPress: () {
                      Navigator.pushNamed(context, LoginScreen.routeName);
                    }).show();
              },
              backgroundColor: kColorRedSlow,
              child: Icon(
                Icons.logout,
                color: Colors.white,
              ),
            ),
            bottomNavigationBar: NavigationBarTheme(
                data: NavigationBarThemeData(
                    indicatorColor: Color(hexColor('#4ca2cd')),
                    labelTextStyle: MaterialStateProperty.all(
                      TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    )),
                child: NavigationBar(
                    height: 60,
                    backgroundColor: Color(hexColor('#DFF0E2')),
                    selectedIndex: index,
                    onDestinationSelected: (index) =>
                        setState(() => this.index = index),
                    destinations: [
                      NavigationDestination(
                          icon: Icon(Icons.note), label: 'Peminjaman'),
                      NavigationDestination(
                          icon: Icon(Icons.book), label: 'List Buku'),
                      NavigationDestination(
                          icon: Icon(Icons.edit), label: 'Kelola Buku'),
                      NavigationDestination(
                          icon: Icon(Icons.person), label: 'List Tamu'),
                    ]))));
  }

  int hexColor(String color) {
    String newColor = '0xff' + color;
    newColor = newColor.replaceAll('#', '');
    int finalColor = int.parse(newColor);
    return finalColor;
  }
}
