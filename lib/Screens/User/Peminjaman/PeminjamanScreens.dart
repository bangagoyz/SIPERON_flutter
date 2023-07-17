import 'package:flutter/material.dart';
import 'package:perpus/Components/User/Peminjaman/CreatePeminjaman/PeminjamanComponents.dart';
import 'package:perpus/Utils/constants.dart';
import 'package:perpus/size_config.dart';
import 'dart:convert';

class PeminjamanScreens extends StatelessWidget {
  static var routeName = '/form_peminjaman_screens';
  static var dataBuku;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    dataBuku = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: Text(
          "Peminjaman",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: PeminjamanComponent(),
    );
  }
}
