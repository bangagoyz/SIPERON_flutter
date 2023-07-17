import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:perpus/Components/User/Buku/BukuComponents.dart';
import 'package:perpus/Screens/User/Buku/bukuScanner.dart';
import 'package:perpus/Utils/constants.dart';

class DataBukuScreens extends StatelessWidget {
  static var routeName = '/list_buku_screens';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey[900],
          title: Text(
            "Pinjam Buku",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: BukuComponents(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, bukuScanner.routeName);
          },
          backgroundColor: kColorTeal,
          child: Icon(
            Icons.qr_code_2,
            color: Colors.white,
          ),
        ));
  }
}
