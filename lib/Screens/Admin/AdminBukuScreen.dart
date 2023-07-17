import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:perpus/Components/Admin/HomeAdminComponents.dart';
import 'package:perpus/Screens/Login/LoginScreens.dart';
import 'package:perpus/Utils/constants.dart';
import 'package:perpus/size_config.dart';
import 'package:perpus/Components/Register/RegisterComponent.dart';

import 'Crud/InputBukuScreen.dart';

class AdminBukuScreen extends StatelessWidget {
  static String routeName = "/buku_admin";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Kelola Buku",
          style: TextStyle(color: mTitleColor, fontWeight: FontWeight.bold),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, InputBukuScreens.routeName);
            },
            child: Row(children: const [
              Icon(
                Icons.add,
                color: mTitleColor,
              ),
              Text(
                "Input Data",
                style:
                    TextStyle(color: mTitleColor, fontWeight: FontWeight.bold),
              )
            ]),
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: HomeAdminComponent(),
    );
  }
}
