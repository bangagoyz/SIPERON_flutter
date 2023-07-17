import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:perpus/Components/User/Buku/BukuComponents.dart';
import 'package:perpus/Components/User/Kunjungan/UserKunjunganComponents.dart';
import 'package:perpus/Screens/User/Buku/bukuScanner.dart';
import 'package:perpus/Screens/User/Kunjungan/KunjunganScanner.dart';
import 'package:perpus/Utils/constants.dart';

class UserKunjunganScreens extends StatelessWidget {
  static var routeName = '/user_kunjungan_screens';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey[900],
          title: Text(
            "Kunjungan Anda",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: UserKunjunganComponents(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, KunjunganScanner.routeName);
          },
          backgroundColor: kColorTeal,
          child: Icon(
            Icons.qr_code_2,
            color: Colors.white,
          ),
        ));
  }
}
