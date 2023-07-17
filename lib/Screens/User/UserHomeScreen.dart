import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:perpus/Components/User/UserHomeComponent.dart';
import 'package:perpus/Utils/constants.dart';
import 'package:perpus/size_config.dart';

import '../Login/LoginScreens.dart';

class UserHomeScreen extends StatelessWidget {
  static String routeName = "/home_user";
  static var userDataLogin;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    userDataLogin = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueGrey[900],
        title: Text(
          "SIPERON",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: Icon(
          Icons.home,
          color: Colors.white,
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: UserHomeComponent(),
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
    );
  }
}
